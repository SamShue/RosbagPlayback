function [pose2d] = parseOdomMessage2D(odomMessage)
%PARSEODOMMESSAGE Read odometry message and parse into 2D Pose
%   Function checks for valid message type, then parses message into 2d
%   pose with orientation wrapped to 360 degrees.
    if(contains(odomMessage.MessageType,'Odom'))
        % get pose from odom message
        position(1) = odomMessage.Pose.Pose.Position.X;
        position(2) = odomMessage.Pose.Pose.Position.Y;
        orientation(1) = odomMessage.Pose.Pose.Orientation.W;
        orientation(2) = odomMessage.Pose.Pose.Orientation.X;
        orientation(3) = odomMessage.Pose.Pose.Orientation.Y;
        orientation(4) = odomMessage.Pose.Pose.Orientation.Z;
        % convert quaternions to eulter angels (quat2eul format: WXYZ -> ZXY)
        orientation = quat2eul(orientation);
        pose2d = [position(1), position(2), wrapTo360(rad2deg(orientation(1)))];
    else
        warning('Parsed message not of Odom type');
    end
end
