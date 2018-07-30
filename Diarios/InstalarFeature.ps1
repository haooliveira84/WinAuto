function PegaArgumento {
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true
        )]
        [String] $frase
    )

        Write-Host -NoNewline "Retorno: "
        Write-Host "$frase" -BackgroundColor Red -ForegroundColor Yellow
}