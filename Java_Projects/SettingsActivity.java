package com.example.panicbutton;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.EditTextPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.os.Bundle;
import android.preference.PreferenceFragment;
import android.preference.PreferenceManager;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import android.preference.PreferenceActivity;
import android.os.Bundle;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

class contact
{
    String name =  " ", number = " ";
    contact(String n, String num)
    {
        name = n;
        number = num;
    }

    String getName()
    {
        return name;
    }

    String getNumber()
    {
        return number;
    }

    public String toString()
    {
        return getName();
    }
}

public class SettingsActivity extends AppCompatActivity {
    private EditText number;
    DatabaseHelper mDatabaseHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.settings_activity);
        Intent intent = getIntent();

        number = (EditText) findViewById(R.id.PhoneNo);
        EditText name = (EditText) findViewById(R.id.Contact);
        mDatabaseHelper = new DatabaseHelper(this);
        Button btnSave, btnViewData;
        btnSave = findViewById(R.id.button);
        btnViewData = findViewById(R.id.button2);
        btnSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
               contact newEntry = new contact(name.getText().toString(), number.getText().toString());
                if (number.length() != 0 && name.length() != 0) {
                    AddData(newEntry);
                    number.setText("");
                    name.setText("");
                } else {
                    toastMessage("You must put something in the text field!");
                }

            }
        });
        btnViewData.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(SettingsActivity.this, ListDataActivity.class);
                startActivity(intent);
            }
        });
    }

    public void AddData(contact newEntry) {
        boolean insertData = mDatabaseHelper.addData(newEntry);

        if (insertData) {
            toastMessage("Data Successfully Inserted!");
        }
        else {
            toastMessage("Something went wrong");
        }
    }
    private void toastMessage(String message){
        Toast.makeText(this,message, Toast.LENGTH_SHORT).show();
    }





}