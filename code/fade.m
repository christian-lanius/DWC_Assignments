% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
%       FADING FUNCTION   EXACTLY SAME AS THE JAKE‘S MODEL      %
%                               Y.SANADA               
% Start: Channel Start Time
%
% End:Channel End Time%
% No_of_Path: Number of Fading Channel 
%
% Doppler:Maximum Doppler Shift
%
% Decay:Decay Constant of the Multipath
% Interval:Sampling Interval
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
function  channel=fade( Start, End, No_of_Path, Doppler, Decay, Interval )
No = 7;
N = 4*No+2;
PAI = 4.0*atan(1.0);
channel = zeros(No_of_Path,End-Start+1);
for k=1:No_of_Path
    for time=Start:End
        ss=0;
        sc=0;
        for n=1:No
            Bn=PAI*n/(No+1);
            rn=2.0*PAI*(k-1)/(No+1);
            wn=PAI*2.0*Doppler*cos(n*PAI*2.0/N);
            sc=sc+2.0*cos(Bn)*cos(wn*time*Interval+Bn+rn);
            ss=ss+2.0*sin(Bn)*cos(wn*time*Interval+Bn+rn);
        end
        sc=sc+sqrt(2.0)*cos(PAI*2.0*Doppler*time*Interval+rn);
        real=Decay^(k-1)*(sc/sqrt(No*2.0+1.0));
        image=Decay^(k-1)*(ss/sqrt(No*2.0+1.0));
        channel(k,time-Start+1) = real + sqrt(-1)*image;
    end
end