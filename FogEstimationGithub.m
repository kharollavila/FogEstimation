% Estimación de la niebla mediante los métodos propuestos por:
% 1) Hildebrandt y Eltahir (2008)
% 2) Unsworth y Wilshaw (1989)
% Desarrollado por Kharoll Avila
% Publicado en github en febrero del 2025

% Definir ruta de trabajo
ruta= "C:\Users\USUARIO\Downloads";
cd (ruta)

clear

% Importar datos desde excel
[num_col, txt_col]=xlsread('input_FOG_Github.xlsx');
x_y=num_col(:,3:4);
num_col=num_col(:,5:13);

% Extraer datos por columna
uz=num_col(:,2);        % Velocidad del viento
z=num_col(:,9);         % Altura del viento
hc=num_col(:,3);        % Altura de la vegetación
Rc=num_col(:,8);        % Radio del dosel
a=num_col(:,5);         
A=num_col(:,4)/1000;    % Radio característico de la vegetación
Fic_Foc=num_col(:,6);   % Promedio entre el factor de incidencia y el factor de compresión por la columna atmosférica
Fvi=num_col(:,7);       % Factor conjugado de intersección

% constantes: 
g=9.8;                  % gravedad
k=0.41;                 % Von Karman
na= 1.77E-05;           % Visc. Dinámica del aire
pw= 1000;               % Densidad del agua
rd= 1.00E-05;           %Radio de la niebla
E0 = 3;                 %Cte
lm=6.61E-08;            %Lamnda
v=1.3927E-05;           %Viscosidad Cinematica del aire
Ain=150;                
kp=1.80e-05;            %Difusividad molecular de la particula
LWC=8.5E-05;            %Contenido de humedad de la niebla
t_expo=86400;

% Hildebrandt y Eltahir (2008)
z0=0.15*hc;
d=2/3*hc;
uc=(uz*k)./(log(z./z0));
ra=log((z-d)./z0)./(k*uc);
dp=rd*2;
vg=(2/9)*(rd*rd*g*pw)./(na);

Cc=1+(2*lm/dp)*(1.257+0.4*exp(-1.1*dp/lm));
Tp=(Cc*pw*dp*dp)/(18*na);

St=(vg*uc)./(g*A);
dc=Tp*a./St;
Re=uz.*dc/v;

for ii=1:size(num_col,1)
    if Re(ii)<4E+04
        CB(ii)=0.467; nb(ii)=0.5;
    elseif Re(ii)<4e+05
        CB(ii)=0.203; nb(ii)=0.6;
    else
        CB(ii)=0.035; nb(ii)=0.8;
    end % if Re
end % for ii

CB=CB';
nb=nb';

Sc=v/kp;
Ein=Ain.*uc.*(10.^(-St))*2*dp./dc;
Re_EB=Re.^(nb-1);
EB=CB.*(Sc^(-2/3)).*Re_EB;
Eim=(St./(St+a)).^2;
E=Ein+EB+Eim;

c=2*hc./Rc+1;
r_surp=1./(E0*uc.*E);

vt=1./(ra+r_surp);

vd=c.*vt+vg;

phz_HE=LWC.*vd;

FOG_HE=phz_HE*t_expo;
FOGyr_HE=FOG_HE*365;
FOG_Ef_HE=FOGyr_HE.*Fic_Foc/100;

% Unsworth y Wilshaw (1989)
lnB=log((z-d)./z0);
Df=LWC*((k*k*uz)./lnB+vg)*1000000;
PH_B=Df.*c*t_expo./(pw*1000);
PHyr_B=PH_B*365;
FOG_Ef_B=PHyr_B.*Fvi/100;

% Publicar resultados en excel
Res_title={'x','y','PHyr_HE','Fic_Foc','PH_Ef_HE','PHyr_B','Fvi','PH_Ef_B'};
Res=[x_y FOGyr_HE Fic_Foc FOG_Ef_HE PHyr_B Fvi FOG_Ef_B];
d_xlsx='output_FOG_Github.xlsx'; % Nombre excel con resultados
xlswrite(d_xlsx,Res,1,'A2');
xlswrite(d_xlsx,Res_title);

disp('Se ha generado excel')
