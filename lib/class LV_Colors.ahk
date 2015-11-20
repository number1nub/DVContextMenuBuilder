class LV_Colors
{
   static MessageHandler := "LV_Colors_WM_NOTIFY"
   static WM_NOTIFY := 0x4E
   static SubclassProc := RegisterCallback("LV_Colors_SubclassProc")
   static Critical := 100

   __New(P*) {
      Return false
   }

   On_NM_CUSTOMDRAW(H, L) {
      static CDDS_PREPAINT          := 0x00000001
      static CDDS_ITEMPREPAINT      := 0x00010001
      static CDDS_SUBITEMPREPAINT   := 0x00030001
      static CDRF_DODEFAULT         := 0x00000000
      static CDRF_NEWFONT           := 0x00000002
      static CDRF_NOTIFYITEMDRAW    := 0x00000020
      static CDRF_NOTIFYSUBITEMDRAW := 0x00000020
      static CLRDEFAULT             := 0xFF000000
      static NMHDRSize := (2 * A_PtrSize) + 4 + (A_PtrSize - 4)
      static ItemSpecP := NMHDRSize + (5 * 4) + A_PtrSize + (A_PtrSize - 4)
      static NCDSize  := NMHDRSize + (6 * 4) + (3 * A_PtrSize) + (2 * (A_PtrSize - 4))
      static ClrTxP   :=  NCDSize
      static ClrTxBkP := ClrTxP + 4
      static SubItemP := ClrTxBkP + 4
      static ClrBkP   := SubItemP + 8
      DrawStage := NumGet(L + NMHDRSize, 0, "UInt")
      , Row := NumGet(L + ItemSpecP, 0, "UPtr") + 1
      , Col := NumGet(L + SubItemP, 0, "Int") + 1
      if This[H].IsStatic
         Row := This.MapIndexToID(H, Row)
      if (DrawStage = CDDS_SUBITEMPREPAINT) {
         NumPut(This[H].CurTX, L + ClrTxP, 0, "UInt"), NumPut(This[H].CurTB, L + ClrTxBkP, 0, "UInt"), NumPut(This[H].CurBK, L + ClrBkP, 0, "UInt")
         ClrTx := This[H].Cells[Row][Col].T, ClrBk := This[H].Cells[Row][Col].B
         if (ClrTx != "")
            NumPut(ClrTX, L + ClrTxP, 0, "UInt")
         if (ClrBk != "")
            NumPut(ClrBk, L + ClrTxBkP, 0, "UInt"), NumPut(ClrBk, L + ClrBkP, 0, "UInt")
         if (Col > This[H].Cells[Row].MaxIndex()) && !This[H].HasKey(Row)
            Return CDRF_DODEFAULT
         Return CDRF_NOTIFYSUBITEMDRAW
      }
      if (DrawStage = CDDS_ITEMPREPAINT) {
         This[H].CurTX := This[H].TX, This[H].CurTB := This[H].TB, This[H].CurBK := This[H].BK
         ClrTx := ClrBk := ""
         if This[H].Rows.HasKey(Row)
            ClrTx := This[H].Rows[Row].T, ClrBk := This[H].Rows[Row].B
         if (ClrTx != "")
            NumPut(ClrTx, L + ClrTxP, 0, "UInt"), This[H].CurTX := ClrTx
         if (ClrBk != "")
            NumPut(ClrBk, L + ClrTxBkP, 0, "UInt") , NumPut(ClrBk, L + ClrBkP, 0, "UInt")
            , This[H].CurTB := ClrBk, This[H].CurBk := ClrBk
         if This[H].Cells.HasKey(Row)
            Return CDRF_NOTIFYSUBITEMDRAW
         Return CDRF_DODEFAULT
      }
      if (DrawStage = CDDS_PREPAINT) {
         Return CDRF_NOTIFYITEMDRAW
      }
      Return CDRF_DODEFAULT
   }

   MapIndexToID(HWND, Row) {
      ; LVM_MAPINDEXTOID = 0x10B4 -> http://msdn.microsoft.com/en-us/library/bb761139(v=vs.85).aspx
      SendMessage, 0x10B4, % (Row - 1), 0, , % "ahk_id " . HWND
      Return ErrorLevel
   }

   ; Register ListView control for coloring
   Attach(HWND, StaticMode := False, NoSort := True, NoSizing := True) {
      static LVM_GETBKCOLOR     := 0x1000
      static LVM_GETHEADER      := 0x101F
      static LVM_GETTEXTBKCOLOR := 0x1025
      static LVM_GETTEXTCOLOR   := 0x1023
      static LVM_SETEXTENDEDLISTVIEWSTYLE := 0x1036
      static LVS_EX_DOUBLEBUFFER := 0x00010000
      if !DllCall("User32.dll\IsWindow", "Ptr", HWND, "UInt")
         Return False
      if This.HasKey(HWND)
         Return False
      ; Set LVS_EX_DOUBLEBUFFER style to avoid drawing issues, if it isn't set as yet.
      SendMessage, % LVM_SETEXTENDEDLISTVIEWSTYLE, % LVS_EX_DOUBLEBUFFER, % LVS_EX_DOUBLEBUFFER, , % "ahk_id " . HWND
      if (ErrorLevel = "FAIL")
         Return False
      ; Get the default colors
      SendMessage, % LVM_GETBKCOLOR, 0, 0, , % "ahk_id " . HWND
      BkClr := ErrorLevel
      SendMessage, % LVM_GETTEXTBKCOLOR, 0, 0, , % "ahk_id " . HWND
      TBClr := ErrorLevel
      SendMessage, % LVM_GETTEXTCOLOR, 0, 0, , % "ahk_id " . HWND
      TxClr := ErrorLevel
      ; Get the header control
      SendMessage, % LVM_GETHEADER, 0, 0, , % "ahk_id " . HWND
      Header := ErrorLevel
      ; Store the values in a new object
      This[HWND] := {BK: BkClr, TB: TBClr, TX: TxClr, Header: Header, IsStatic: !!StaticMode}
      if (NoSort)
         This.NoSort(HWND)
      if (NoSizing)
         This.NoSizing(HWND)
      Return True
   }

   ; Unregister ListView control
   Detach(HWND) {
      ; Remove the subclass, if any
      static LVM_GETITEMCOUNT := 0x1004
      if (This[HWND].SC)
         DllCall("Comctl32.dll\RemoveWindowSubclass", "Ptr", HWND, "Ptr", This.SubclassProc, "Ptr", HWND)
      This.Remove(HWND, "")
      WinSet, Redraw, , % "ahk_id " . HWND
      Return True
   }

   ; Set background and/or text color for the specified row
   Row(HWND, Row, BkColor := "", TxColor := "") {
      if !This.HasKey(HWND)
         Return False
      if This[HWND].IsStatic
         Row := This.MapIndexToID(HWND, Row)
      if (BkColor = "") && (TxColor = "") {
         This[HWND].Rows.Remove(Row, "")
         Return True
      }
      BkBGR := TxBGR := ""
      if BkColor Is Integer
         BkBGR := ((BkColor & 0xFF0000) >> 16) | (BkColor & 0x00FF00) | ((BkColor & 0x0000FF) << 16)
      if TxColor Is Integer
         TxBGR := ((TxColor & 0xFF0000) >> 16) | (TxColor & 0x00FF00) | ((TxColor & 0x0000FF) << 16)
      if (BkBGR = "") && (TxBGR = "")
         Return False
      if !This[HWND].HasKey("Rows")
         This[HWND].Rows := {}
      if !This[HWND].Rows.HasKey(Row)
         This[HWND].Rows[Row] := {}
      if (BkBGR != "")
         This[HWND].Rows[Row].Insert("B", BkBGR)
      if (TxBGR != "")
         This[HWND].Rows[Row].Insert("T", TxBGR)
      Return True
   }

   ; Set background and/or text color for the specified cell
   Cell(HWND, Row, Col, BkColor := "", TxColor := "") {
      if !This.HasKey(HWND)
         Return False
      if This[HWND].IsStatic
         Row := This.MapIndexToID(HWND, Row)
      if (BkColor = "") && (TxColor = "") {
         This[HWND].Cells.Remove(Row, "")
         Return True
      }
      BkBGR := TxBGR := ""
      if BkColor Is Integer
         BkBGR := ((BkColor & 0xFF0000) >> 16) | (BkColor & 0x00FF00) | ((BkColor & 0x0000FF) << 16)
      if TxColor Is Integer
         TxBGR := ((TxColor & 0xFF0000) >> 16) | (TxColor & 0x00FF00) | ((TxColor & 0x0000FF) << 16)
      if (BkBGR = "") && (TxBGR = "")
         Return False
      if !This[HWND].HasKey("Cells")
         This[HWND].Cells := {}
      if !This[HWND].Cells.HasKey(Row)
         This[HWND].Cells[Row] := {}
      This[HWND].Cells[Row, Col] := {}
      if (BkBGR != "")
         This[HWND].Cells[Row, Col].Insert("B", BkBGR)
      if (TxBGR != "")
         This[HWND].Cells[Row, Col].Insert("T", TxBGR)
      Return True
   }

   ; Prevent / allow sorting by click on a header item dynamically.
   NoSort(HWND, Apply := True) {
      static HDM_GETITEMCOUNT := 0x1200
      if !This.HasKey(HWND)
         Return False
      if (Apply)
         This[HWND].NS := True
      Else
         This[HWND].Remove("NS")
      Return True
   }

   ; Prevent / allow resizing of columns dynamically.
   NoSizing(HWND, Apply := True) {
      static OSVersion := DllCall("Kernel32.dll\GetVersion", "UChar")
      static HDS_NOSIZING := 0x0800
      if !This.HasKey(HWND)
         Return False
      HHEADER := This[HWND].Header
      if (Apply) {
         if (OSVersion < 6) {
            if !(This[HWND].SC) {
               DllCall("Comctl32.dll\SetWindowSubclass", "Ptr", HWND, "Ptr", This.SubclassProc, "Ptr", HWND, "Ptr", 0)
               This[HWND].SC := True
            } Else {
               Return True
            }
         } Else {
            Control, Style, +%HDS_NOSIZING%, , ahk_id %HHEADER%
         }
      } Else {
         if (OSVersion < 6) {
            if (This[HWND].SC) {
               DllCall("Comctl32.dll\RemoveWindowSubclass", "Ptr", HWND, "Ptr", This.SubclassProc, "Ptr", HWND)
               This[HWND].Remove("SC")
            } Else {
               Return True
            }
         } Else {
            Control, Style, -%HDS_NOSIZING%, , ahk_id %HHEADER%
         }
      }
      Return True
   }

   OnMessage(Apply:=true) {
      if (Apply)
         OnMessage(This.WM_NOTIFY, This.MessageHandler)
      Else if (This.MessageHandler = OnMessage(This.WM_NOTIFY))
         OnMessage(This.WM_NOTIFY, "")
      Return True
   }
}

LV_Colors_SubclassProc(H, M, W, L, S, R) {
   static HDN_BEGINTRACKA := -306
   static HDN_BEGINTRACKW := -326
   static WM_NOTIFY := 0x4E
   Critical, % LV_Colors.Critical
   if (M = WM_NOTIFY) {
      C := NumGet(L + (A_PtrSize * 2), 0, "Int")
      if (C = HDN_BEGINTRACKA) || (C = HDN_BEGINTRACKW)
         Return True
   }
   Return DllCall("Comctl32.dll\DefSubclassProc", "Ptr", H, "UInt", M, "Ptr", W, "Ptr", L, "UInt")
}

LV_Colors_WM_NOTIFY(W, L) {
   static NM_CUSTOMDRAW := -12
   static LVN_COLUMNCLICK := -108
   Critical, % LV_Colors.Critical
   if LV_Colors.HasKey(H := NumGet(L + 0, 0, "UPtr")) {
      M := NumGet(L + (A_PtrSize * 2), 0, "Int")
      if (M = NM_CUSTOMDRAW)
         Return LV_Colors.On_NM_CUSTOMDRAW(H, L)
      if (LV_Colors[H].NS && (M = LVN_COLUMNCLICK))
         Return 0
   }
}