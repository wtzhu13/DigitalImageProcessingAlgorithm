x = -3 :0.02 :10;
sizeX = size(x);
y = zeros(1, sizeX(2));
for i = 1: sizeX(2);
    if x(i) < 0
        y(i) = 0;
    elseif x(i) >= 0 && x(i) <= 6.28
        y(i) = sin(5*x(i));
    else
        y(i) = sin(15*x(i)); 
    end
end
ylim([-2, 2]);
set(gca,'YTick', -2:0.02:2);
plot(x, y);      