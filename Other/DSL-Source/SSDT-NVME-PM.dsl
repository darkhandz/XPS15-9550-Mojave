// For solving instant wake by hooking GPRW

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "_NVME-PM", 0)
{
#endif

    External(_SB.PCI0.RP09.SSD0, DeviceObj)
    Scope(_SB.PCI0.RP09.SSD0)
    {
        Name (NVME, One)
        Method (_DSM, 4, NotSerialized)
        {
            If (LEqual (Arg2, Zero))
            {
                Return (Buffer (One)
                {
                    0x03
                })
            }
            If (LEqual (NVME, One))
            {
                Return (Package (0x06)
                {
                    // "deep-idle" property stripped down credit syscl
                    "deep-idle",
                    One,
                    "use-msi",
                    One,
                    "nvme-LPSR-during-S3-S4",
                    One
                })
            }
            Else
            {
                Return (Package (0x02)
                {
                    // refined else-if case credit syscl
                    // eliminate "sata-express-power-off" and "ssd-off-in-S4" credit syscl
                    "use-msi",
                    One,
                })
            }
        }   
    }
    
    External (GTF0, IntObj)
    External(_SB.PCI0.SATA.PRT0, DeviceObj)
    Scope(_SB.PCI0.SATA.PRT0)
    {
        Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
        {
            Name (GBU0, Buffer (0x07)
            {
                0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x00
            })
            CreateByteField (GBU0, Zero, GB00)
            CreateByteField (GBU0, One, GB01)
            CreateByteField (GBU0, 0x02, GB02)
            CreateByteField (GBU0, 0x03, GB03)
            CreateByteField (GBU0, 0x04, GB04)
            CreateByteField (GBU0, 0x05, GB05)
            CreateByteField (GBU0, 0x06, GB06)
            If (LEqual (SizeOf (Arg0), 0x0200))
            {
                CreateWordField (Arg0, 0x9C, W780)
                If (And (W780, 0x08))
                {
                    Store (0x10, GB00)
                    Store (0x03, GB01)
                    Store (0xEF, GB06)
                }
                Else
                {
                    Store (0x90, GB00)
                    Store (0x03, GB01)
                    Store (0xEF, GB06)
                }
            }
            Store (GBU0, GTF0)
        }
        Method (_GTF, 0, NotSerialized)
        {
            Return (GTF0)
        }   
    }
    
    
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF