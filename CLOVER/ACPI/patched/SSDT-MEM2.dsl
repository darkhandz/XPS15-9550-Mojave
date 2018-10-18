#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "_MEM2", 0)
{
#endif
    Device (MEM2) // iGPU use MEM2 instead of TPMX, and RW memory. syscl
            {
                Name (_HID, EisaId ("PNP0C01"))
                Name (_UID, 0x02)
                Name (_STA, 0x0F)
                Name (_CRS, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0x20000000, 0x00200000, )
                    Memory32Fixed (ReadWrite, 0x40000000, 0x00200000, )
                })
            }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF