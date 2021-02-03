package com.example.panicbutton;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.location.LocationProvider;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.Settings;
import android.telephony.SmsManager;
import android.util.Log;
import android.view.View;

import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.tasks.CancellationToken;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

import java.io.BufferedReader;
import java.io.Console;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.security.Provider;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import static java.lang.Thread.sleep;

public class MainActivity extends AppCompatActivity implements LocationListener {
    //String sms = "Please help or send help! I am sending you this message because I am in danger, and possibly unable to get on the phone. Here is my location:";
    String sms = "This is a test of the Panic Button System. Please disregard this message, as it is only a test. You do NOT need to send help to the following address:";
    String otherSMS = "If the address shown is not viable, please copy and paste the latitute and longitude into google maps";
    FusedLocationProviderClient fusedLocationClient;
    TextView textView;
    Button butt;
    EditText edit;
    String message;
    String otherMessage;
    String number = "";
    protected LocationListener locationListener;
    DatabaseHelper mDataBase;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mDataBase = new DatabaseHelper(this);
        textView = (TextView) findViewById(R.id.textView);
        butt = findViewById(R.id.panicbutton);
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this);
        LocationManager locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
        int PERMISSION_ALL = 1;
        String[] PERMISSIONS = {
                Manifest.permission.CALL_PHONE,
                Manifest.permission.SEND_SMS,
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION
        };

        if (!hasPermissions(MainActivity.this, PERMISSIONS)) {
            ActivityCompat.requestPermissions(MainActivity.this, PERMISSIONS, PERMISSION_ALL);
        }

        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, 50);
            ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, 60);
            return;
        }
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, this);

            butt.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if((textView.getText().toString().equals("Finding Location...")))
                    {
                        toastMessage("Please wait for your location to be found.\nIf you are receiving this message repeatedly, you may have poor reception and should call 911 if you have not already done so.");
                    }
                    else
                    {
                        Cursor data = mDataBase.getData();
                        while (data.moveToNext()) {
                            number = data.getString(1);//get da phone number and sms
                            sms(number, sms);
                            sms(number, message);
                            sms(number, otherSMS);
                            sms(number, otherMessage);//in case the address is insufficient
                        }
                        try {
                            FileInputStream fin = openFileInput("contact.txt");
                            int c;
                            String temp = "";
                            while ((c = fin.read()) != -1) {
                                temp = temp + Character.toString((char) c);
                            }
                            dial(temp);
                            fin.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }

                }
            });

        }
    @Override
    public void onLocationChanged(Location location) {
        try {
            //initialize geocoder to get the address from a longitude and latitude
            Geocoder geocoder = new Geocoder(MainActivity.this, Locale.getDefault());
            //initialize address list
            List<Address> address = geocoder.getFromLocation(
                    location.getLatitude(), location.getLongitude(), 1);
            //made an address from the given longitude and latitude
            //the address object has multiple data members, including the original long and lat
            //but also the address can directly be taken from the coordinates
            message = address.get(0).getAddressLine(0);
            otherMessage =  address.get(0).getLatitude() + ", " + address.get(0).getLongitude();
            textView.setText(message);
        } catch (IOException e) {
            e.printStackTrace();//Verify the data, try to catch exceptions before they cause problems
        }
    }

    public static boolean hasPermissions(Context context, String... permissions) {
        if (context != null && permissions != null) {
            for (String permission : permissions) {
                if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
                    return false;
                }
            }
        }
        return true;
    }
    public void changeSettings(View view)
    {
        Intent settings = new Intent(this, SettingsActivity.class);
        startActivity(settings);
    }

    public void sms(String num, String txt)
    {
        if (!num.isEmpty()) {
            if (ActivityCompat.checkSelfPermission(MainActivity.this, Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED) {
                try {
                    TextView textView = (TextView) findViewById((R.id.textView));
                    SmsManager smsManager = SmsManager.getDefault();
                    smsManager.sendTextMessage(num, null, txt, null, null);
                    Toast.makeText(getApplicationContext(), "SMS sent.",
                            Toast.LENGTH_LONG).show();
                } catch (Exception e) {
                    Toast.makeText(getApplicationContext(),
                            "SMS failed, please try again later!",
                            Toast.LENGTH_LONG).show();
                    e.printStackTrace();
                }
            } else {
                ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.SEND_SMS}, 40);
            }
        }
    }

    public void dial(String num)
    {
        if ((ActivityCompat.checkSelfPermission(MainActivity.this, Manifest.permission.CALL_PHONE) == PackageManager.PERMISSION_GRANTED)) {
            if (num.isEmpty() || num.equals(911)) {
                Intent dial_intent = new Intent(Intent.ACTION_DIAL);
                startActivity(dial_intent);
            }//if empty, its an emergency so let them call 911
            else {
                Intent call_intent = new Intent(Intent.ACTION_CALL);//the intent is to call
                num = "tel:" + num;
                //it's an action call since we are not calling using normal methods of phone calls
                call_intent.setData(Uri.parse(num));
                startActivity(call_intent);
            }//otherwise, let's make a call!
        } else {
            ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.CALL_PHONE}, 2);
        }
    }

    private void toastMessage(String message){
        Toast.makeText(this,message, Toast.LENGTH_LONG).show();
    }
}
