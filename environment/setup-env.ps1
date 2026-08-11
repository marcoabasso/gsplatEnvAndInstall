param(
    [string]$EnvironmentPath = (Join-Path (Split-Path -Parent $PSScriptRoot) '..\gsplat-env'),
    [string]$PythonCommand = 'py'
)

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$environmentPath = [System.IO.Path]::GetFullPath($EnvironmentPath)

if ($PythonCommand -eq 'py') {
    & py -3.12 -m venv $environmentPath
} else {
    & $PythonCommand -m venv $environmentPath
}

$python = Join-Path $environmentPath 'Scripts\python.exe'
if (-not (Test-Path -LiteralPath $python)) {
    throw "Virtual environment creation failed: $python was not found."
}

& $python -m pip install --upgrade 'pip==26.1.2' 'setuptools==81.0.0' 'wheel==0.47.0'
& $python -m pip install --index-url https://download.pytorch.org/whl/cu128 'torch==2.10.0+cu128' 'torchvision==0.25.0+cu128'
& $python -m pip install -r (Join-Path $PSScriptRoot 'requirements-lock.txt')

git -C $repositoryRoot submodule update --init --recursive
& $python -m pip install --no-build-isolation $repositoryRoot

& $python -c "import torch, gsplat; print(f'torch={torch.__version__} cuda={torch.version.cuda} available={torch.cuda.is_available()}'); print(f'gsplat={gsplat.__version__}')"

