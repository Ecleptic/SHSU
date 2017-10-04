package edu.shsu.lab4;


import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

import static java.security.AccessController.getContext;

/**
 * Created by cgreen on 3/23/17.
 */

public class HelloSpinner extends AppCompatActivity {
    public static final String TAG = "GetNameActivity";
    android.widget.EditText name;
    android.widget.Button submit;

    public void onCreate (Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.setContentView(R.layout.spinner_layout);

        Spinner spinner = (Spinner) findViewById(R.id.spinner);
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(
                this, R.array.planets_array, android.R.layout.simple_spinner_item); adapter.setDropDownViewResource
                (android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);
        spinner.setOnItemSelectedListener(new MyOnItemSelectedListener());
    }
    public class MyOnItemSelectedListener implements AdapterView.OnItemSelectedListener {

        public void onItemSelected(AdapterView<?> parent,
                                   View view, int pos, long id) {
//        Toast.makeText(parent.getContext()), "The planet is " +
//                parent.getItemAtPosition(pos).toString(), Toast.LENGTH_LONG).show();
            Toast.makeText(parent.getContext(), "The planet is "+
                    parent.getItemAtPosition(pos).toString(), Toast.LENGTH_LONG).show();

        }

        public void onNothingSelected(AdapterView parent) {
            // Do nothing.
        }
    }
}
