
$template = "simple_template.css"
$mappings = @(Get-ChildItem *.json)

$mappings | ForEach-Object {
    $content = Get-Content $template
    $map = [string](Get-Content $_) | ConvertFrom-Json
    $mapKeys = $map | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
    $mapKeys | ForEach-Object {
		$key = '\$' + $_ + '\$'
		$value = $map.$_
        $content = $content -replace $key, $value
    }

    $content | Set-Content "..\simple_$($_.BaseName).css"
}
