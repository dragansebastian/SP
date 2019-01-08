%Semnal triunghiular
%Rezolutie temporara adecvata


P = 40; %Perioada
D = 12; %Durata semnalelor
N = 50; %Numar de coeficienti
w0 = 2*pi/P; %pulsatia unghiulara a semnalului
t_tr = 0:0.02:D; %esantionarea semnalului original
x_tr = sawtooth((pi/12)*t_tr,0.5)/2+0.5; %semnalul triunghiular original
t = 0:0.02:P; %esantionarea semnalului modificat
x = zeros(1,length(t)); %initializare a semnalului modificat cu valori nule
x(t<=D) = x_tr; %modificam valorile nule cu valori din semnalul original
                %unde avem valori din t <= durata semnalului 
figure(1);
plot(t,x),title('x(t)(linie solida) si reconstructia folosind N coeficienti (linie punctata)'); %afisare x(t)
hold on;


for k = -N:N %k este variabila dupa care se realizeaza suma
    x_t = x_tr; %x_t e semnalul realizat dupa formula SF data
    x_t = x_t .* exp(-1i*k*w0*t_tr); %inmultire intre doua matrice element cu element
    X(k+N+1) = 0; %initializare cu valoare nula
    for i = 1:length(t_tr)-1
        X(k+N+1) = X(k+N+1) + (t_tr(i+1)-t_tr(i)) * (x_t(i)+x_t(i+1))/2; %reconstructia folosind coeficientii
    end
end

for i = 1:length(t) %i este variabila dupa care se realizeaza suma
    x_finit(i) = 0; %initializare cu valoare nula
    for k=-N:N
        x_finit(i) = x_finit(i) + (1/P) * X(k+51) * exp(1i*k*w0*t(i));  %reconstructia folosind coeficientii
    end
end
plot(t,x_finit,'--'); %afisare reconstructie semnal folosind cei N coeficienti

figure(2);
w=-50*w0:w0:50*w0; %w este vectorul ce ne va permite afisarea spectrului functiei
stem(w/(2*pi),abs(X)),title('Spectrul lui x(t)'); %afisarea spectrului
