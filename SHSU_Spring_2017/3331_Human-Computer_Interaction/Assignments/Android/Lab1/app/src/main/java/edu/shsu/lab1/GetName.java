package edu.shsu.lab1;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;


/**
 * Created by cgreen on 3/23/17.
 */

public class GetName  extends Activity implements android.view.View.OnClickListener{
    public static final String TAG = "GetNameActivity";
    android.widget.EditText name;
    android.widget.Button submit;

    public void onClick(View arg0){
        Intent nameIntent = new Intent(this,Lab1Activity.class);
        nameIntent.putExtra("oname",name.getText().toString());
        this.startActivity(nameIntent);
    }

    public void onCreate (Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        this.setContentView(R.layout.name_getter);

        name = (EditText) this.findViewById(R.id.et);
        submit = (Button) this.findViewById(R.id.bt);

        submit.setOnClickListener(this);
    }

}
