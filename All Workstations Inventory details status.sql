SELECT
	DISTINCT (VRS.Netbios_Name0) as 'hostname',
	MAX(SYSOU.System_OU_Name0) as 'OU',
	CASE when VRS.Client0 = 1 Then 'Yes' Else 'No' End 'Client',
	CASE when VRS.Active0 = 1 Then 'Yes' Else 'No' End 'Active',
	CASE 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '1' THEN 'Virtual' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '2' THEN 'Blade Server' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '3' THEN 'Desktop' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '4' THEN 'Low-Profile Desktop' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '5' THEN 'Pizza-Box' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '6' THEN 'Mini Tower' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '7' THEN 'Tower' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '8' THEN 'Portable' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '9' THEN 'Laptop' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '10' THEN 'Notebook' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '11' THEN 'Hand-Held'
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '12' THEN 'Mobile Device in Docking Station' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '13' THEN 'All-in-One' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '14' THEN 'Sub-Notebook' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '15' THEN 'Space Saving Chassis' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '16' THEN 'Ultra Small Form Factor' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '17' THEN 'Server Tower Chassis' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '18' THEN 'Mobile Device in Docking Station' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '19' THEN 'Sub-Chassis' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '20' THEN 'Bus-Expansion chassis' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '21' THEN 'Peripheral Chassis' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '22' THEN 'Storage Chassis' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '23' THEN 'Rack-Mounted Chassis' 
		WHEN v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 LIKE '24' THEN 'Sealed-Case PC' 
	ELSE 'Unknown' END AS 'Chassis Type',
	LEFT(MAX(v_GS_NETWORK_ADAPTER_CONFIGUR.IPAddress0), ISNULL(NULLIF(CHARINDEX(',',MAX(v_GS_NETWORK_ADAPTER_CONFIGUR.IPAddress0)) - 1, -1),LEN(MAX(v_GS_NETWORK_ADAPTER_CONFIGUR.IPAddress0))))as 'IPAddress',
	MAX (v_GS_NETWORK_ADAPTER_CONFIGUR.MACAddress0) as 'MACAddress',
	v_RA_System_SMSAssignedSites.SMS_Assigned_Sites0 as 'AssignedSite',
	VRS.Client_Version0 as 'ClientVersion',
	VRS.Creation_Date0 as 'ClientCreationDate',
	VRS.AD_Site_Name0 as 'ADSiteName',
	dbo.v_GS_OPERATING_SYSTEM.InstallDate0 AS 'OSInstallDate',
	DateDiff(D, dbo.v_GS_OPERATING_SYSTEM.InstallDate0, GetDate()) 'OSInstallDateAge',
	Convert(VarChar, v_Gs_Operating_System.LastBootUpTime0,100) as 'LastBootDate',
	DateDiff(D, Convert(VarChar, v_Gs_Operating_System.LastBootUpTime0,100), GetDate()) as 'LastBootDateAge',
	PC_BIOS_DATA.SerialNumber00 as 'SerialNumber',
	v_GS_SYSTEM_ENCLOSURE.SMBIOSAssetTag0 as 'AssetTag',
	PC_BIOS_DATA.ReleaseDate00 as 'ReleaseDate',
	PC_BIOS_DATA.Name00 as 'BiosName',
	PC_BIOS_DATA.SMBIOSBIOSVersion00 as 'BiosVersion',
	v_GS_PROCESSOR.Name0 as 'ProcessorName',
	CASE 
		WHEN Computer_System_DATA.Manufacturer00 LIKE 'VMware%' THEN 'VMWare'
		WHEN Computer_System_DATA.Manufacturer00 LIKE 'Gigabyte%' THEN 'Gigabyte'
		WHEN Computer_System_DATA.Manufacturer00 LIKE 'VIA Technologies%' THEN 'VIA Technologies'
		WHEN Computer_System_DATA.Manufacturer00 LIKE 'MICRO-STAR%' THEN 'MICRO-STAR'
	ELSE Computer_System_DATA.Manufacturer00 END 'Manufacturer',
	Computer_System_DATA.Model00 as 'Model',
	Computer_System_DATA.SystemType00 as 'OSType',
	v_GS_COMPUTER_SYSTEM.Domain0 as 'DomainName',
	VRS.User_Name0 as 'UserName',
	v_R_User.Mail0 as 'EMailID',
	CASE 
		WHEN v_GS_COMPUTER_SYSTEM.domainrole0 = 0 THEN 'Standalone Workstation'
		WHEN v_GS_COMPUTER_SYSTEM.domainrole0 = 1 THEN 'Member Workstation'
		WHEN v_GS_COMPUTER_SYSTEM.domainrole0 = 2 THEN 'Standalone Server'
		WHEN v_GS_COMPUTER_SYSTEM.domainrole0 = 3 THEN 'Member Server'
		WHEN v_GS_COMPUTER_SYSTEM.domainrole0 = 4 THEN 'Backup Domain Controller'
		WHEN v_GS_COMPUTER_SYSTEM.domainrole0 = 5 THEN 'Primary Domain Controller'
	End 'Role',
	CASE 
		WHEN Operating_System_DATA.Caption00 = 'Microsoft(R) Windows(R) Server 2003, Enterprise Edition' THEN 'Microsoft(R) Windows(R) Server 2003 Enterprise Edition'
		WHEN Operating_System_DATA.Caption00 = 'Microsoft(R) Windows(R) Server 2003, Standard Edition' THEN 'Microsoft(R) Windows(R) Server 2003 Standard Edition'
		WHEN Operating_System_DATA.Caption00 = 'Microsoft(R) Windows(R) Server 2003, Web Edition' THEN 'Microsoft(R) Windows(R) Server 2003 Web Edition'
	Else Operating_System_DATA.Caption00 END 'OSName',
	Operating_System_DATA.CSDVersion00 as 'ServicePack',
	Operating_System_DATA.Version00 as 'Version',
	((v_GS_X86_PC_MEMORY.TotalPhysicalMemory0/1024)/1000) as 'TotalRAMSize',
	max(v_GS_LOGICAL_DISK.Size0 / 1024) as 'TotalHDDSize',
	v_GS_WORKSTATION_STATUS.LastHWScan as 'LastHWScan',
	DateDiff(D, v_GS_WORKSTATION_STATUS.LastHwScan, GetDate()) as 'LastHWScanAge'

FROM V_R_System VRS
	LEFT OUTER JOIN PC_BIOS_DATA on PC_BIOS_DATA.MachineID = VRS.ResourceId
	LEFT OUTER JOIN Operating_System_DATA on Operating_System_DATA.MachineID = VRS.ResourceId
	LEFT OUTER JOIN v_GS_WORKSTATION_STATUS on v_GS_WORKSTATION_STATUS.ResourceID = VRS.ResourceId
	LEFT OUTER JOIN Computer_System_DATA on Computer_System_DATA.MachineID = VRS.ResourceId
	LEFT OUTER JOIN v_GS_X86_PC_MEMORY on v_GS_X86_PC_MEMORY.ResourceID = VRS.ResourceId
	LEFT OUTER JOIN v_GS_PROCESSOR on v_GS_PROCESSOR.ResourceID = VRS.ResourceId
	LEFT OUTER JOIN v_GS_SYSTEM_ENCLOSURE on v_GS_SYSTEM_ENCLOSURE.ResourceID = VRS.ResourceId
	LEFT OUTER JOIN v_Gs_Operating_System on v_Gs_Operating_System .ResourceID = VRS.ResourceId
	LEFT OUTER JOIN v_RA_System_SMSAssignedSites on v_RA_System_SMSAssignedSites.ResourceID = VRS.ResourceId
	LEFT OUTER JOIN v_GS_COMPUTER_SYSTEM on v_GS_COMPUTER_SYSTEM.ResourceID = VRS.ResourceId
	LEFT OUTER JOIN v_FullCollectionMembership on v_FullCollectionMembership.ResourceID = VRS.ResourceId
	LEFT OUTER JOIN v_GS_NETWORK_ADAPTER_CONFIGUR on v_GS_NETWORK_ADAPTER_CONFIGUR.ResourceID = VRS.ResourceId
	LEFT JOIN v_RA_System_SystemOUName SYSOU on Vrs.ResourceID=SYSOU.ResourceID
	LEFT OUTER JOIN v_GS_LOGICAL_DISK on v_GS_LOGICAL_DISK.ResourceID = Vrs.ResourceId AND v_GS_LOGICAL_DISK.DriveType0 = 3
	LEFT OUTER JOIN v_R_User on VRS.User_Name0 = v_R_User.User_Name0

WHERE VRS.Operating_System_Name_and0 LIKE '%Workstation%' AND (VRS.Obsolete0 = 0 or VRS.Obsolete0 is null)

GROUP BY VRS.Netbios_Name0,VRS.Client0,VRS.Active0,v_GS_SYSTEM_ENCLOSURE.ChassisTypes0,
	v_RA_System_SMSAssignedSites.SMS_Assigned_Sites0,VRS.Client_Version0,Vrs.Creation_Date0,
	Vrs.AD_Site_Name0,v_Gs_Operating_System.InstallDate0,v_Gs_Operating_System.LastBootUpTime0,
	PC_BIOS_DATA.SerialNumber00,v_GS_SYSTEM_ENCLOSURE.SMBIOSAssetTag0,PC_BIOS_DATA.ReleaseDate00,
	PC_BIOS_DATA.Name00,PC_BIOS_DATA.SMBIOSBIOSVersion00,v_GS_PROCESSOR.Name0,Computer_System_DATA.Manufacturer00,
	Computer_System_DATA.Model00,Computer_System_DATA.SystemType00,v_GS_COMPUTER_SYSTEM.Domain0,
	Vrs.User_Domain0,Vrs.User_Name0,v_R_User.Mail0,v_GS_COMPUTER_SYSTEM.DomainRole0,Operating_System_DATA.Caption00,
	Operating_System_DATA.CSDVersion00,Operating_System_DATA.Version00,v_GS_X86_PC_MEMORY.TotalPhysicalMemory0,v_GS_WORKSTATION_STATUS.LastHWScan
		 
		 
