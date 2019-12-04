global key
while 1
    touch = brick.TouchPressed(4); %setting touch to port 4
    brick.SetColorMode(2, 2); %setting colormode to colorcode for port 2
    color = brick.ColorCode(2);
    distance = brick.UltrasonicDist(1); %setting ultrasonic distance to port 1
    display(distance); %displaying distance
    display(color); %displaying color
    
    brick.MoveMotor('A', 50); %starting the move
    brick.MoveMotor('D',50);
    
    if distance > 45 %if the distance is greater than 45 then turn right 
        brick.MoveMotorAngleRel('A', 50, 200, 'Brake'); %200 degrees for motor A and -150 for D which is opposite of left turn
        brick.MoveMotorAngleRel('D', 50, -150, 'Brake');
        brick.WaitForMotor('A');
        brick.WaitForMotor('D');
        brick.MoveMotor('A', 50); %moving at half speed
        brick.MoveMotor('D', 50);
        pause(3);
        brick.StopAllMotors('Coast');
    end
    
    if distance < 5 %the case where the robot is too close to the wall
        brick.MoveMotor('A', 50);%move one at a slightly lower speed to correct
        brick.MoveMotor('D', 45);
        pause(1);
    end
    
    if color == 5 %if the color is equal to red then stop
        brick.StopAllMotors('Coast');
        pause(2);
        brick.MoveMotor('A', 50);
        brick.MoveMotor('D',50);
    end

    if touch %the case for left turn
        brick.MoveMotorAngleRel('D', 50, -100, 'Coast');
        brick.MoveMotorAngleRel('A',50,-100, 'Coast');
        brick.WaitForMotor('D');
        brick.WaitForMotor('A'); %waiting for motors
    
        brick.MoveMotorAngleRel('D', 50, 200, 'Brake'); %%moving port a 200 degrees
        brick.MoveMotorAngleRel('A', 50, -150, 'Brake'); %moving port b -150 degrees for a left turn
        brick.WaitForMotor('D');
        brick.WaitForMotor('A'); 
    end

InitKeyboard(); %pick up at green and yellow
    while color == 3 || color == 4
        pause(0.1);
        brick.StopAllMotors('Coast'); %stopping all motors for remote control
        switch key
            case 'uparrow'
                disp('up arrow pressed');
                brick.MoveMotor('A',50);
                brick.MoveMotor('D',50);
            case 'downarrow'
                disp('Down arrow pressed');
                brick.MoveMotor('A',-50);
                brick.MoveMotor('D',-50);
            case 'leftarrow'
                brick.StopMotor('A');
                brick.MoveMotor('D',50);
                disp('left arrow pressed');
            case 'rightarrow'
                disp('right arrow pressed');
                brick.StopMotor('D');
                brick.MoveMotor('A',50);
            case 'u' 
                disp('arm moving up');
                brick.MoveMotor('C',50);
            case 'd'
                disp('Moving arm down');
                brick.MoveMotor('C',-10);
            case 0
                disp('No Key pressed');
                brick.StopAllMotors('Coast');
            case 'q'
                brick.StopAllMotors('Coast');
                break;
        end
    end 
    CloseKeyboard();
end 