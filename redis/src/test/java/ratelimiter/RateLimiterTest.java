package ratelimiter;

import org.junit.jupiter.api.AfterAll;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class RateLimiterTest {

  private static Jedis redis;
  private static JedisPool pool;

  @BeforeAll
  static void setUp() {
    pool = new JedisPool("localhost", 6379);
    redis = pool.getResource();
  }

  @AfterAll
  static void shutDown() {
    pool.close();
  }

  @Test
  void threeConsecutiveRequestsTest() {
    String label = "test1";
    redis.del(label);
    RateLimiter rateLimiter = new RateLimiter(redis, label, 2, 1);
    assertTrue(rateLimiter.pass());
    assertTrue(rateLimiter.pass());
    assertFalse(rateLimiter.pass());
  }

  @Test
  void requestsWithHalfSecInterval() {
    String label = "test2";
    redis.del(label);
    RateLimiter rateLimiter = new RateLimiter(redis, label, 2, 1);
    assertTrue(rateLimiter.pass());
    sleep(500);
    assertTrue(rateLimiter.pass());
    sleep(500);
    assertTrue(rateLimiter.pass());
    sleep(500);
    assertTrue(rateLimiter.pass());
  }

  @Test
  void requestsWithSecInterval() {
    String label = "test3";
    redis.del(label);
    RateLimiter rateLimiter = new RateLimiter(redis, label, 2, 2);
    assertTrue(rateLimiter.pass());
    sleep(1000);
    assertTrue(rateLimiter.pass());
    sleep(1000);
    assertTrue(rateLimiter.pass());
    sleep(1000);
    assertTrue(rateLimiter.pass());
  }

  @Test
  void twoConsecutiveRequestsSecIntervalTwoConsecutiveRequestsTest() {
    String label = "test4";
    redis.del(label);
    RateLimiter rateLimiter = new RateLimiter(redis, label, 2, 1);
    assertTrue(rateLimiter.pass());
    assertTrue(rateLimiter.pass());
    sleep(1000);
    assertTrue(rateLimiter.pass());
    assertTrue(rateLimiter.pass());
  }

  @Test
  void requestWithInsufficientIntervalsTest() {
    String label = "test5";
    redis.del(label);
    RateLimiter rateLimiter = new RateLimiter(redis, label, 2, 1);
    assertTrue(rateLimiter.pass());
    sleep(400);
    assertTrue(rateLimiter.pass());
    sleep(400);
    assertFalse(rateLimiter.pass());
    assertFalse(rateLimiter.pass());
    sleep(400);
    assertTrue(rateLimiter.pass());
  }

  @Test
  void youShallNotPassTest() {
    String label = "test6";
    redis.del(label);
    RateLimiter rateLimiter = new RateLimiter(redis, label, 0, 1);
    assertFalse(rateLimiter.pass());
    assertFalse(rateLimiter.pass());
  }

  // Тест со звездочкой
//  @Test
//  void slidingWindowTest() {
//    String label = "test7";
//    redis.del(label);
//    RateLimiter rateLimiter = new RateLimiter(redis, label, 3, 3);
//    assertTrue(rateLimiter.pass());
//    sleep(2000);
//    assertTrue(rateLimiter.pass());
//    assertTrue(rateLimiter.pass());
//    sleep(1000);
//    assertTrue(rateLimiter.pass());
//    assertFalse(rateLimiter.pass());
//  }

  private void sleep(long millis) {
    try {
      Thread.sleep(millis);
    } catch (InterruptedException e) {
      throw new RuntimeException(e);
    }
  }

}
