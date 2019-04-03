SELECT
    DISTINCT VRS.Name0 as 'hostname',
    App.ARPDisplayName0 as 'DisplayName',
    App.InstallDate0 as 'InstalledDate',
    App.ProductVersion0 as 'Version'
FROM V_R_System VRS
    LEFT JOIN v_GS_INSTALLED_SOFTWARE App ON VRS.ResourceID = App.ResourceID
    LEFT JOIN Computer_System_DATA St on VRS.ResourceID = st.MachineID
    LEFT JOIN v_GS_OPERATING_SYSTEM Os on VRS.ResourceID = Os.ResourceID
    LEFT Join v_FullCollectionMembership as Col on VRS.ResourceID = Col.ResourceID
WHERE VRS.Client0 = 1 AND VRS.Obsolete0 = 0
ORDER BY VRS.Name0, App.ProductVersion0

