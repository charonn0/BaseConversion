#tag Module
Protected Module BaseConvert
	#tag Method, Flags = &h1
		Protected Function Bin(Number As UInt64) As String
		  Return ToBase(Number, 2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DigitLookup(Digit As String, Base As Integer) As UInt64
		  Dim bound As Integer = UBound(BaseArray)
		  If bound = -1 Then
		    BaseArray = Split("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/", "")
		    bound = UBound(BaseArray)
		  End If
		  If Base < 2 Or Base - 1 > bound Then Raise New TypeMismatchException
		  
		  If Base < 36 Then
		    Return BaseArray.IndexOf(Digit)
		    
		  Else ' case sensitive
		    For x As Integer = 0 To bound
		      If StrComp(BaseArray(x), Digit, 1) = 0 Then Return x
		    Next
		  End If
		  
		  Raise New KeyNotFoundException
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FromBase(Value As String, FromBase As Integer) As UInt64
		  ' Converts the value into base-10 using FromBase
		  Call DigitLookup("0", 2)
		  If FromBase - 1 > UBound(BaseArray) Or FromBase < 2 Then Raise New OutOfBoundsException
		  Dim Result As UInt64
		  For i As UInt64 = 1 To Value.Len
		    Dim digit As String = Value.Mid(i, 1) ' the encoded digit
		    Dim addend As UInt64 = DigitLookup(digit, FromBase) ' its numeric value
		    If addend > FromBase - 1 Then Raise New UnsupportedFormatException
		    Result = FromBase * Result + addend
		  Next
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FromLiteral(Data As String) As UInt64
		  ' Allows literals in any base up to 36 by using the first digit (in base-36) as the base
		  ' e.g. a base-10 literal would be prefix with &A
		  Call DigitLookup("0", 2)
		  Dim literal As String
		  If Left(Data, 1) = "&" Then literal = Left(Data, 2)
		  Data = Replace(Data, literal, "")
		  Dim base As Integer = BaseArray.IndexOf(Right(literal, 1))
		  Return FromBase(Data, base)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Hex(Number As UInt64) As String
		  Return ToBase(Number, 16)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Oct(Number As UInt64) As String
		  Return ToBase(Number, 8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Str(Number As UInt64, NumericBase As Integer = 10) As String
		  Return ToBase(Number, NumericBase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ToBase(Value As UInt64, NewBase As Integer) As String
		  ' Converts an UInt64 into a string representation of the number in NewBase
		  Call DigitLookup("0", 2)
		  If NewBase - 1 > UBound(BaseArray) Or NewBase < 2 Then Raise New OutOfBoundsException
		  Dim digit() As String
		  Do
		    Dim remainder As UInt64 = Value Mod NewBase
		    Value = Value \ NewBase
		    digit.Insert(0, BaseArray(remainder))
		  Loop Until Value = 0
		  Return Join(digit, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Val(Data As String) As UInt64
		  Select Case Left(Data, 2)
		  Case "&b" ' binary
		    Return FromBase(Right(Data, Data.Len - 2), 2)
		  Case "&t" ' ternary
		    Return FromBase(Right(Data, Data.Len - 2), 3)
		  Case "&o" ' octal
		    Return FromBase(Right(Data, Data.Len - 2), 8)
		  Case "&d" ' decimal
		    Return FromBase(Right(Data, Data.Len - 2), 10)
		  Case "&h", "&u" ' hexadecimal
		    Return FromBase(Right(Data, Data.Len - 2), 16)
		  Case "&g" ' Hexatri*g*esimal
		    Return FromBase(Right(Data, Data.Len - 2), 36)
		  Else ' assume base-10 with no literal
		    Return FromBase(Data, 10)
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private BaseArray() As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
