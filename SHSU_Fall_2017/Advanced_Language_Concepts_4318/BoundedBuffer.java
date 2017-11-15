
/*
@author     j.n.magee 14/11/96
@goober     g.w.smith 10/10/97
@gobSmacker c.k.green 11/12/17
*/

import java.util.Random;

/*********************BUFFER*****************************/
class Bowl {

    private int[] buf;
    private int in = 0;
    private int out = 0;
    private int count = 0;
    private int size;

    Bowl(int size) {
        this.size = size;
        buf = new int[size];
    }

    synchronized public void put(int o) {
        while (count == size) {
            System.out.println("YESSS The bowl is filled, thanks Bubba!");
            notifyAll();
            try {
                wait();
            } catch (InterruptedException e) {
            }
        }
        buf[in] = o;
//        System.out.println("o:"+o);
//        System.out.println("buf[in]"+buf[in]);
        ++count;
        in = (in + 1) % size;
    }

    synchronized public int get() {
        while (count == 0) {
            System.out.println("Noooooo the bowl is empty Bubba! Come fix it!");
            notifyAll();
            try {
                wait();
            } catch (InterruptedException e) {
            }
        }
        int ret_val = buf[out];
        --count;
        out = (out + 1) % size;
        return (ret_val);
    }

} // end class Bowl

/*******************PRODUCER************************/
class TeachingAssistant extends Thread {

    Bowl buf_;

    TeachingAssistant(Bowl b) {
        buf_ = b;
    }

    public void run() {
        try {
            int value = 0;
            while (true) {
                value += 1;
                buf_.put(value);
                System.out.println("Added piece of candy ");
                Thread.sleep(10);
            }
        } catch (InterruptedException e) {
            System.out.println("TeachingAssistant: But I wasn't done!!!");
        }
    }
} // end class TeachingAssistant

/********************CONSUMER*******************************/
class Professor extends Thread {
    Bowl buf_;
    Random rand = new Random();

    Professor(Bowl b) {
        buf_ = b;
    }

    public void run() {
        try {
            int value = 0;
            Thread.sleep(rand.nextInt(500));
            while (true) {
                value = buf_.get();
                System.out.println("A Prof ate: " + value + " total candies 🍬");
                Thread.sleep(rand.nextInt(2000));
            }
        } catch (InterruptedException e) {
            System.out.println("Professor: But I wasn't done!!! 😵");
        }
    }
} // end class Professor

public class BoundedBuffer {

    public static void main(String args[]) {
        int mCandies = 50;
        int nTeachers = 3;
        Bowl Buff = new Bowl(mCandies);
        TeachingAssistant TABubba = new TeachingAssistant(Buff);

        Professor[] profs = new Professor[nTeachers];
        for (int i = 0; i < profs.length; i++)
            profs[i] = new Professor(Buff);

        TABubba.start();
        for (int i = 0; i < profs.length; i++)
            profs[i].start();

        try {

            Thread.sleep(100000);

            System.out.println("Main: I'm tired of waiting!");

            TABubba.interrupt();
            for (int i = 0; i < profs.length; i++)
                profs[i].interrupt();
            TABubba.join();
            for (int i = 0; i < profs.length; i++)
                profs[i].join();
        } catch (InterruptedException e) {
        }

    }
}