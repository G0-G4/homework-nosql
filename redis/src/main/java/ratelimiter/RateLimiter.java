package ratelimiter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.time.Instant;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.args.ExpiryOption;

public class RateLimiter {

  private final Jedis redis;
  private final String label;
  private final long maxRequestCount;
  private final long timeWindowSeconds;
  private String START = "start";
  private String CURR = "curr";
  private String PREV = "prev";

  private long limmiterStart;
  private long boxNumber;

  public RateLimiter(Jedis redis, String label, long maxRequestCount, long timeWindowSeconds) {
    this.redis = redis;
    this.label = label;
    this.maxRequestCount = maxRequestCount;
    this.timeWindowSeconds = timeWindowSeconds;

    START = "start" + label;
    CURR = "curr" + label;
    PREV = "prev" + label;

    redis.set("0", "0");
    redis.set("1", "0");
    redis.set("-1", "0");
  }

  public boolean pass() {
    System.out.println();
    if (limmiterStart == 0) {
      limmiterStart = System.currentTimeMillis();
    }
    long time = System.currentTimeMillis();
    boxNumber = (time - limmiterStart) / 1000 / timeWindowSeconds;
    redis.incr(""+boxNumber);

    System.out.println("from start " + ""+(time - limmiterStart));
    System.out.println("box number " + boxNumber);
    System.out.println("now " + time);
    System.out.println("max " + (time - timeWindowSeconds * 1000));

    System.out.println("from box start " + (time - (limmiterStart + boxNumber*timeWindowSeconds*1000)));

    redis.zadd(label, (double) time, ""+time);
    redis.zremrangeByScore(label, 0, time - timeWindowSeconds * 1000);

    System.out.println(redis.zrangeByScore(label, 0, time));
    long request_count = redis.zcard(label);

    System.out.println("req " + request_count);
    if (request_count <= maxRequestCount) {
      System.out.println(true);
      return true;
    }
    System.out.println(false);
    return false;
  }

  public static void main(String[] args) {
    JedisPool pool = new JedisPool("localhost", 6379);

    try (Jedis redis = pool.getResource()) {
      RateLimiter rateLimiter = new RateLimiter(redis, "pr_rate", 1, 1);

      BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
      long prev = Instant.now().toEpochMilli();
      long now;

      while (true) {
        try {
          String s = br.readLine();
          if (s == null || s.equals("q")) {
            return;
          }
          boolean passed = rateLimiter.pass();

          now = Instant.now().toEpochMilli();
          if (passed) {
            System.out.printf("%d ms: %s", now - prev, "passed");
            prev = now;
          } else {
            System.out.printf("%d ms: %s", now - prev, "limited");
          }
        } catch (IOException e) {
          e.printStackTrace();
        }
      }

    }
  }
}
