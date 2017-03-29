package edu.shsu.lab1;

import android.support.v4.widget.TextViewCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class Lab1Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lab1);

        Bundle myInput = this.getIntent().getExtras();
        TextView t = new TextView(this);
        t  = (TextView)findViewById(R.id.mainTextView);
        t.setText("Hello "+ (myInput.getString("oname")));
    }
}
