m4_divert(-1)
m4_changecom
m4_define(`_C_LABEL',
           m4_ifelse(_SYSTEM, linux, `$1',`_$1'))
m4_define(`_CLIB_LABEL',
           m4_ifelse(_SYSTEM, linux, `$1', 
                     _SYSTEM, watcom, `$1_', `_$1'))
m4_define(`_DATA_SEG',
  m4_ifelse( _SYSTEM, bcc,   `segment _DATA public align=4 class=DATA use32',
             _SYSTEM, watcom, `segment _DATA public align=4 class=DATA use32',
              `segment .data'))

m4_define(`_DATA_SEG_BARE',
  m4_ifelse( _SYSTEM, bcc,   `segment _DATA',
             _SYSTEM, watcom, `segment _DATA',
              `segment .data'))

m4_define(`_BSS_SEG',
  m4_ifelse( _SYSTEM, bcc,   `segment _BSS public align=4 class=BSS use32',
             _SYSTEM, watcom,   `segment _BSS public align=4 class=BSS use32',
             `segment .bss'))

m4_define(`_BSS_SEG_BARE',
  m4_ifelse( _SYSTEM, bcc,   `segment _BSS',
             _SYSTEM, watcom,   `segment _BSS',
             `segment .bss'))


m4_define(`_DGROUP',
  m4_ifelse( _SYSTEM, bcc, `group DGROUP _BSS _DATA',
             _SYSTEM, watcom, `group DGROUP _BSS _DATA', `' ))

m4_define(`_TEXT_SEG',
  m4_ifelse( _SYSTEM, bcc,   
   `segment _TEXT public align=1 class=CODE use32',
            _SYSTEM, watcom,   
   `segment _TEXT public align=1 class=CODE use32',
              `segment .text'))

m4_define(`_TEXT_SEG_BARE',
  m4_ifelse( _SYSTEM, bcc,   
   `segment _TEXT',
            _SYSTEM, watcom,   
   `segment _TEXT',
              `segment .text'))
m4_divert
