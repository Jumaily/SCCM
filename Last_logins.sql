Declare @CollectionID Varchar(8) SET @CollectionID = 'SMS00001'
SELECT DISTINCT (VRS.Netbios_Name0) AS 'hostname', VRS.User_Name0 AS 'UserName', VRS.ResourceID, Last_Logon_Timestamp0
FROM V_R_System VRS Left Outer
JOIN v_FullCollectionMembership
    ON v_FullCollectionMembership.ResourceID = VRS.ResourceId Left Outer
JOIN v_R_User
    ON VRS.User_Name0 = v_R_User.User_Name0
WHERE VRS.Operating_System_Name_and0 LIKE '%Workstation%'
        AND (VRS.Obsolete0 = 0
        OR VRS.Obsolete0 is null)
        AND VRS.Client0 = 1
        AND v_FullCollectionMembership.CollectionID = @CollectionID
GROUP BY  VRS.Netbios_Name0,VRS.Client0, Vrs.User_Name0, Vrs.ResourceID, Vrs.Last_Logon_Timestamp0
ORDER BY  VRS.Netbios_Name0