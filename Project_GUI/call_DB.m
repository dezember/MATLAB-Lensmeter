function out=call_DB()
    [calibration_plot]=dlmread('FarSightDB.dat');
    farX=(calibration_plot(:,1));
    farY=(calibration_plot(:,2));
    farerr=(calibration_plot(:,3));

    [calibration_plotn]=dlmread('NearSightDB.dat');
    nearX=(calibration_plotn(:,1));
    nearY=(calibration_plotn(:,2));
    nearerr=(calibration_plotn(:,3));
    
    out={farX,farY,farerr,nearX,nearY,nearerr};
end