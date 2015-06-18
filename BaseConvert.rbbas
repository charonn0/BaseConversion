#tag Module
Protected Module BaseConvert
	#tag Method, Flags = &h1
		Protected Function Bin(Number As UInt64) As String
		  Return ToBase(Number, 2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FromBase(Value As String, FromBase As Integer) As UInt64
		  ' Converts the value into base-10 using FromBase
		  If UBound(BaseArray) = -1 Then UseExtensions = mUseExtensions
		  If FromBase - 1 > UBound(BaseArray) Or FromBase < 2 Then Raise New OutOfBoundsException
		  Dim Result As UInt64
		  For i As UInt64 = 1 To Value.Len
		    Dim addend As UInt64 
		    Dim s As String = Value.Mid(i, 1)
		    If mUseExtensions Then
		      For x As Integer = 0 To UBound(BaseArray)
		        If StrComp(BaseArray(x), s, 1) = 0 Then
		          addend = x
		          Exit For
		        End If
		      Next
		    Else
		      addend = BaseArray.IndexOf(s)
		    End If
		    Result = FromBase * Result + addend
		  Next
		  Return Result
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
		Protected Function ToBase(Value As UInt64, NewBase As Integer) As String
		  ' Converts an UInt64 into a string representation of the number in NewBase
		  If UBound(BaseArray) = -1 Then UseExtensions = mUseExtensions
		  If NewBase - 1 > UBound(BaseArray) Or NewBase < 2 Then Raise New OutOfBoundsException
		  Dim digit() As String
		  Do Until Value = 0
		    Dim remainder As UInt64 = Value Mod NewBase
		    Value = Value \ NewBase
		    digit.Insert(0, BaseArray(remainder))
		  Loop
		  Return Join(digit, "")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private BaseArray() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseExtensions As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  return mUseExtensions
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mUseExtensions = value
			  BaseArray = Split("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/", "")
			  If Not mUseExtensions Then ReDim BaseArray(61)
			  
			  
			End Set
		#tag EndSetter
		Protected UseExtensions As Boolean
	#tag EndComputedProperty


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
