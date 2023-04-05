# Tracert -> NR Flex
$results = New-Object -TypeName psobject

# Get result
$result = cmd.exe /c tracert teams.microsoft.com

# get Latency
$result_time = $result | Select-String " ms"

$line_num = 0
foreach ($line in $result_time) {
    $line_str = $line -replace "ms","" -split " +"
    # $line_str_comp = $line_str -replace "*","0"
    Set-Variable -Name ("result_time" + $line_num) -Value ($line_str)
    $line_num = $line_num + 1
}

$i=0
while($i -le ($line_num -1) ){
    $tempstr = Get-Variable -Name ("result_time" + $i ) -ValueOnly
    $j = 2
    while($j -le 4){
        try{
            $tempstr[$j] = [int]$tempstr[$j]
        }Catch{
            $tempstr[$j] = [int]"0"
        }finally{
            $j +=1
        }
    } 
	$tempstr[0] = ([int]$tempstr[2]+[int]$tempstr[3]+[int]$tempstr[4])/3
	Set-Variable -Name ("result_time" + $i ) -Value ($tempstr)
    $i +=1
}

# Set Number of hops
$hop_num = $line_num

# Set Return Values
$results | Add-Member -MemberType NoteProperty -Name "target" -Value 'teams.microsoft.com' 
$results | Add-Member -MemberType NoteProperty -Name "RoutTrip" -Value $hop_num
$results | Add-Member -MemberType NoteProperty -Name "Router1" -Value 'Router1'
$results | Add-Member -MemberType NoteProperty -Name "Router1RT" -Value $result_time0[0]
$results | Add-Member -MemberType NoteProperty -Name "Router2" -Value 'Router2'
$results | Add-Member -MemberType NoteProperty -Name "Router2RT" -Value $result_time0[1]

$results | ConvertTo-Json
