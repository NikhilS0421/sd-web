#!/usr/bin/env pwsh
$basedir=Split-Path $MyInvocation.MyCommand.Definition -Parent

$exe=""
if ($PSVersionTable.PSVersion -lt "6.0" -or $IsWindows) {

  # are installed in the same directory
  $exe=".exe"
}
$ret=0
if (Test-Path "$basedir/node$exe") {
  # Support pipeline input
  if ($MyInvocation.ExpectingInput) {
    $input | & "$basedir/node$exe"  "$basedir/../rollup/dist/bin/rollup" $args
  } else {
    & "$basedir/node$exe"  "$basedir/../rollup/dist/bin/rollup" $args
  }
  $ret=$LASTEXITCODE
} else {
  # Support pipeline input
  if ($MyInvocation.ExpectingInput) {
    $input | & "node$exe"  "$basedir/../rollup/dist/bin/rollup" $args
  } else {
    & "node$exe"  "$basedir/../rollup/dist/bin/rollup" $args
  }
  $ret=$LASTEXITCODE
}
exit $ret
