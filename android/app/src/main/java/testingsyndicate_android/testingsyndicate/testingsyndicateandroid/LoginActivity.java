package testingsyndicate_android.testingsyndicate.testingsyndicateandroid;

import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class LoginActivity extends AppCompatActivity {

    private final static String CORRECT_PASSCODE = "1234";

    @BindView(R.id.login_button)
    Button loginButton;

    @BindView(R.id.passcode_entry)
    EditText passcodeEntryEditText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        ButterKnife.bind(this);
    }

    @OnClick(R.id.login_button)
    void login() {
        String enteredPasscode = passcodeEntryEditText.getText().toString();
        if (CORRECT_PASSCODE.equals(enteredPasscode)) {
            Intent intent = new Intent(this, HomeActivity.class);
            startActivity(intent);
        } else {
            showIncorrectPasscodeDialog();
        }
    }

    private void showIncorrectPasscodeDialog() {
        new AlertDialog.Builder(this)
                .setTitle(R.string.incorrect_passcode_title)
                .setMessage(R.string.incorrect_passcode_body)
                .setNeutralButton(R.string.ok, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int ignored) {
                        dialogInterface.dismiss();
                    }
                })
                .setIcon(android.R.drawable.ic_dialog_alert)
                .show();
    }
}
