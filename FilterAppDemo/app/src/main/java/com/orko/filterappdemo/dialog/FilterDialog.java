package com.orko.filterappdemo.dialog;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.text.HtmlCompat;
import androidx.databinding.DataBindingUtil;

import com.google.android.material.bottomsheet.BottomSheetBehavior;
import com.google.android.material.bottomsheet.BottomSheetDialog;
import com.google.android.material.bottomsheet.BottomSheetDialogFragment;
import com.orko.all.R;
import com.orko.all.book_appointment.model.CreateAppointmentObject;
import com.orko.all.databinding.VisitAppointmentConfirmDialogBinding;
import com.orko.all.utils.OrkoUtils;

public class FilterDialog extends BottomSheetDialogFragment {

    private BottomSheetBehavior mBehavior;

    private VisitAppointmentConfirmDialogBinding binding;

    private OnVisitAppointmentListener onBookedVisitAppointment;


    private Context mContext;

    private CreateAppointmentObject dataInfo;

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnVisitAppointmentListener) {
            onBookedVisitAppointment = (OnVisitAppointmentListener) context;
        }


        mContext = context;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setStyle(STYLE_NORMAL, R.style.AppBottomSheetDialogTheme2);

    }

    @Override
    public Dialog onCreateDialog(@NonNull final Bundle savedInstanceState) {
        BottomSheetDialog bottomSheet = (BottomSheetDialog) super.onCreateDialog(savedInstanceState);
        View view = View.inflate(getContext(), R.layout.visit_appointment_confirm_dialog, null);

        binding = DataBindingUtil.bind(view);
        bottomSheet.setContentView(view);


        mBehavior = BottomSheetBehavior.from((View) (view.getParent()));
        assert getArguments() != null;
        dataInfo = (CreateAppointmentObject) getArguments().getSerializable("visit_appointment_info");


        mBehavior.setBottomSheetCallback(new BottomSheetBehavior.BottomSheetCallback() {
            @Override
            public void onStateChanged(@NonNull View bottomSheet, int newState) {
                if (newState == BottomSheetBehavior.STATE_DRAGGING) {
                    mBehavior.setState(BottomSheetBehavior.STATE_EXPANDED);
                }
            }

            @Override
            public void onSlide(@NonNull View bottomSheet, float slideOffset) {

            }
        });


        binding.tvTimes.setText(OrkoUtils.convert12HourTime(dataInfo.getSchedule_started_at()));

        binding.tvDate.setText(OrkoUtils.convertReadableDate(dataInfo.getSchedule_date()));


        String text = "Do you want to book a Visit Appointment\n with " + "<b>" + dataInfo.getDoctor_name() + "</b>" + " on";
        binding.tvFor.setText(HtmlCompat.fromHtml(text, HtmlCompat.FROM_HTML_MODE_LEGACY));


        binding.tvFeeAmount.setText(dataInfo.getFee_amount());

        binding.tvChamberDetails.setText(dataInfo.getChamber_info());

        binding.btnCallConfirm.setOnClickListener(v -> {
            onBookedVisitAppointment.onBookedVisitAppointment(dataInfo);
            dismiss();
        });

        return bottomSheet;

    }


    @Override
    public void onStart() {
        super.onStart();
        mBehavior.setState(BottomSheetBehavior.STATE_EXPANDED);
    }


    public interface OnVisitAppointmentListener {
        void onBookedVisitAppointment(CreateAppointmentObject appointmentObject);

    }
}
