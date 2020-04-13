

function strreplace($string, $csvData,$joinUrl){
    $custom_string = $string
    $custom_string = $custom_string.replace('%clientMobile',"$($csvData.clientMobile)")
    $custom_string = $custom_string.replace('%startDateTime',"$($csvData.startDateTime)")
    $custom_string = $custom_string.replace('%endDateTime',"$($csvData.endDateTime)")
    $custom_string = $custom_string.replace('%data1',"$($csvData.data1)")
    $custom_string = $custom_string.replace('%data2',"$($csvData.data2)")
    $custom_string = $custom_string.replace('%data3',"$($csvData.data3)")
    $custom_string = $custom_string.replace('%data4',"$($csvData.data4)")
    $custom_string = $custom_string.replace('%teamsUrl',$joinUrl)
    return $custom_string
}
