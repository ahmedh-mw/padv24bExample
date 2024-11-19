Kd = Simulink.Parameter;
Kd.Value = -0.00134;
Kd.CoderInfo.StorageClass = 'Auto';
Kd.Description = 'Derivative gain of PID controller.';
Kd.DataType = 'double';
Kd.Min = [];
Kd.Max = [];
Kd.DocUnits = '';

Ki = Simulink.Parameter;
Ki.Value = 0.00122;
Ki.CoderInfo.StorageClass = 'Auto';
Ki.Description = 'Integral gain of PID controller.';
Ki.DataType = 'double';
Ki.Min = [];
Ki.Max = [];
Ki.DocUnits = '';

Kp = Simulink.Parameter;
Kp.Value = 0.135;
Kp.CoderInfo.StorageClass = 'Auto';
Kp.Description = 'Proportional gain of PID controller.';
Kp.DataType = 'double';
Kp.Min = [];
Kp.Max = [];
Kp.DocUnits = '';

N = Simulink.Parameter;
N.Value = 1/0.0157;
N.CoderInfo.StorageClass = 'Auto';
N.Description = 'Derivative filter coefficient of PID controller.';
N.DataType = 'double';
N.Min = [];
N.Max = [];
N.DocUnits = '';
