%data from run
load('cwalkspeed.mat');
lat_run=Position.latitude;
lon_run=Position.longitude;
height_run=Position.altitude;
speed=Position.speed;
positionDatetime_run=Position.Timestamp;

Xacc_run = Acceleration.X;
Yacc_run = Acceleration.Y;
Zacc_run = Acceleration.Z;
accelDatetime_run=Acceleration.Timestamp;



% program to calculate BMI, BMR, and recommend daily calorie intake and exercise.

name = input("Hello user! What's your name? " , 's');
% Input: User's age, height, weight, and gender
age = input(sprintf('Nice to meet you, %s! How old are you? ', name));
height = input('How tall are you? (m) ');
weight = input(sprintf('What is your weight, %s? (kg) ', name));
gender = input('What is your gender? (M/f) ', 's');

% Calculate BMI
bmi = weight / (height^2);

% Calculate BMR using Harris-Benedict equation
if gender == 'M' || gender == 'm'
    % Male BMR
    bmr = 10 * weight + 6.25 * (height * 100) - 5 * age + 5;
elseif gender == 'F' || gender == 'f'
    % Female BMR
    bmr = 10 * weight + 6.25 * (height * 100) - 5 * age - 161;
else
    error('Invalid gender input. Please enter M or F.');
end

% Estimate daily calorie intake based on activity level
disp('Select your activity level:');
disp('1. Sedentary (little or no exercise)');
disp('2. Lightly active (light exercise/sports 1-3 days a week)');
disp('3. Moderately active (moderate exercise/sports 3-5 days a week)');
disp('4. Very active (hard exercise/sports 6-7 days a week)');
disp('5. Super active (very hard exercise or a physical job)');
activity_level = input('Enter your choice (1-5): ');

% Activity multiplier
switch activity_level
    case 1
        multiplier = 1.2;
    case 2
        multiplier = 1.375;
    case 3
        multiplier = 1.55;
    case 4
        multiplier = 1.725;
    case 5
        multiplier = 1.9;
    otherwise
        error('Invalid activity level. Please enter a number between 1 and 5.');
end

% Calculate daily calorie needs
daily_calories = bmr * multiplier;

% Recommend exercise to burn daily calorie intake
% Assume average calories burned per hour for moderate exercise = 500 kcal
exercise_hours = daily_calories / 750;

% Display results
fprintf('\nYour BMI is: %.2f\n', bmi);
if bmi < 18.5
    disp('BMI Category: Underweight');
elseif bmi >= 18.5 && bmi < 24.9
    disp('BMI Category: Normal weight');
elseif bmi >= 25 && bmi < 29.9
    disp('BMI Category: Overweight');
else
    disp('BMI Category: Obese');
end

fprintf('Your BMR is: %.2f calories/day\n', bmr);
fprintf('Your daily calorie requirement is: %.2f calories/day\n', daily_calories);
%fprintf('To burn your daily calorie intake, you would need to exercise for approximately %.2f hours.\n', exercise_hours);

%calculating steps
earthCirc = 40075;%Circumference of the Earth in km
totaldis = 0; %Initialize total distance

for i = 1:(length(lat_run)-1)
    lat1 = lat_run(i);     % The first latitude
    lat2 = lat_run(i+1);   % The second latitude
    lon1 = lon_run(i);     % The first longitude
    lon2 = lon_run(i+1);   % The second longitude

    degDis = distance(lat1, lon1, lat2, lon2);

    dis = (degDis/360)*earthCirc;
    
    totaldis = totaldis + dis;
    
end

stride = 0.762; %Average stride (m)

steps = (totaldis*1000)/stride;

%Total calories burned from workout
bcal = steps*0.04;

fprintf('From the data that you gave me the total distance that you traveled is: %.4f km\n', totaldis);
fprintf('Also, you took  %.0f steps\n', steps);
fprintf('That means that you burned %.0f calories. Well done!\n', bcal);


