#tag Window
Begin Window Window1
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   252817407
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   True
   Width           =   600
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  BaseConvert.UseExtensions = True
		  Dim test As UInt64 = 1844674407370955161
		  For i As UInt64 = 2 To 64
		    Dim s As String = BaseConvert.ToBase(test, i)
		    Dim s1 As UInt64 = BaseConvert.FromBase(s, i)
		    If s1 <> test Then Break
		    'If i = 2 And s <> Bin(test) Then Break
		    'If i = 16 And s <> Hex(test) Then Break
		    System.DebugLog("Converted " + Str(test) + " into: " + s + " using base-" + Str(i))
		  Next
		  Break
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConvertFromBase(Value As String, FromBase As UInt64) As UInt64
		  ' Converts the value into base-10 using FromBase
		  Static base() As String = Split("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", "")
		  If FromBase - 1 > UBound(base) Or FromBase < 2 Or FromBase > 36 Then Raise New OutOfBoundsException
		  Dim Result As UInt64
		  For i As UInt64 = 1 To Value.Len
		    Dim datum As UInt64 = Base.IndexOf(Value.Mid(i, 1))
		    Result = FromBase * Result + datum
		  Next
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConvertToBase(Value As UInt64, NewBase As UInt64) As String
		  ' Converts an UInt64 into a string representation of the number in NewBase
		  Static base() As String = Split("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", "")
		  If NewBase - 1 > UBound(base) Or NewBase < 2 Or NewBase > 36 Then Raise New OutOfBoundsException
		  Dim digit() As String
		  Do Until Value = 0
		    Dim remainder As UInt64 = Value Mod NewBase
		    Value = Value \ NewBase
		    digit.Insert(0, base(remainder))
		  Loop
		  Return Join(digit, "")
		End Function
	#tag EndMethod


#tag EndWindowCode

