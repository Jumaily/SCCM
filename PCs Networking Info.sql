SELECT
    vrs.Name0 as 'hostname',
    vrs.User_Name0 as 'username',
    vos.InstallDate0,
    vos.LastBootUpTime0,
    gna.IPAddress0,
    gna.DefaultIPGateway0,
    gna.DHCPServer0,
    CASE gna.DHCPEnabled0
        WHEN 1 THEN 'Yes'
        ELSE 'No'
    END AS 'DHCPEnabled',
    gna.IPSubnet0,
    gna.MACAddress0,
    vrs.AD_Site_Name0,
    CASE Vrs.client0
        WHEN 1 THEN 'Yes'
        ELSE 'No'
    END AS 'Client',
    CASE vrs.Active0
        WHEN 1 THEN 'Active'
        ELSE 'No'
    END AS 'Active'
FROM v_R_System as Vrs
    INNER JOIN v_FullCollectionMembership as Vfc on vrs.ResourceID=vfc.ResourceID
    LEFT JOIN v_GS_NETWORK_ADAPTER_CONFIGUR as GNA on vrs.ResourceID=gna.ResourceID
    LEFT JOIN v_GS_OPERATING_SYSTEM as VOS on vrs.ResourceID=vos.ResourceID
    LEFT JOIN v_GS_DISK as VD on vrs.ResourceID=vd.ResourceID
    LEFT JOIN v_GS_X86_PC_MEMORY as VPM on vrs.ResourceID=vpm.ResourceID
    LEFT JOIN v_GS_PC_BIOS as VPB on vrs.ResourceID=vpb.ResourceID
    LEFT JOIN v_GS_COMPUTER_SYSTEM as VGC on vrs.ResourceID=vgc.ResourceID
WHERE GNA.IPAddress0 IS NOT NULL AND vd.MediaType0 LIKE 'Fixed hard disk media'