SELECT vrs.Name0 as 'ComputerName', Vad.AgentTime as 'LastHeartBeatTime' 
FROM v_R_System as Vrs 
INNER JOIN v_AgentDiscoveries as Vad on Vrs.ResourceID=Vad.ResourceId 
WHERE vad.AgentName LIKE '%Heartbeat Discovery'


