
/*
@author  j.n.magee 14/11/96
@goober  g.w.smith 10/10/97
*/

import java.util.Random;

/*********************BUFFER*****************************/
class Buffer {

    private int[] buf;
    private int in = 0;
    private int out = 0;
    private int count = 0;
    private int size;

    Buffer(int size) {
        this.size = size;
        buf = new int[size];
    }

    synchronized public void put(int o) {
        while (count == size) {
            try {
                wait();
            } catch (InterruptedException e) {
            }
        }
        buf[in] = o;
        ++count;
        in = (in + 1) % size;
        notifyAll();
    }

    synchronized public int get() {
        while (count == 0) {
            try {
                wait();
            } catch (InterruptedException e) {
            }
        }
        int ret_val = buf[out];
        --count;
        out = (out + 1) % size;
        notifyAll();
        return (ret_val);
    }

} // end class Buffer

/*******************PRODUCER************************/
class Producer extends Thread {

    Random TeachingAssistant = new Random();

    Buffer buf_;

    Producer(Buffer b) {
        buf_ = b;
    }

    public void run() {
        try {
            int value = 0;
            while (true) {
                buf_.put(value);
                Thread.sleep(500);
                value += TeachingAssistant.nextInt(100);
            }
        } catch (InterruptedException e) {
            System.out.println("Producer: But I wasn't done!!!");
        }
    }
} // end class Producer

/********************CONSUMER*******************************/
class Consumer extends Thread {
    Buffer buf_;

    Consumer(Buffer b) {
        buf_ = b;
    }

    public void run() {
        try {
            int value;
            while (true) {
                value = buf_.get();
                System.out.println("Obtained value: " + value);
                Thread.sleep(500);
            }
        } catch (InterruptedException e) {
            System.out.println("Consumer: But I wasn't done!!!");
        }
    }
} // end class Consumer

public class BoundedBuffer {

    public static void main(String args[]) {
        Buffer Buff = new Buffer(10);
        Producer Prod = new Producer(Buff);
        Consumer Cons = new Consumer(Buff);

        Prod.start();
        Cons.start();
        try {
            Thread.sleep(500);

            System.out.println("Main: I'm tired of waiting!");
            Prod.interrupt();
            Cons.interrupt();
            Prod.join();
            Cons.join();
        } catch (InterruptedException e) {
        }

    }
}
