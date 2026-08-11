# Reproducing the gsplat environment

This bundle recreates the Python environment used with this customized gsplat checkout.

## Captured runtime

- Windows 11 (AMD64)
- Python 3.12.10
- CUDA Toolkit 12.8 (`nvcc` 12.8.61)
- PyTorch 2.10.0+cu128
- torchvision 0.25.0+cu128
- cuDNN 9.10.2 (reported as 91002)
- gsplat 1.5.3
- GPU used for validation: NVIDIA GeForce RTX 4070

## Recreate

Install Python 3.12 and CUDA Toolkit 12.8, clone this repository recursively, then run from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\environment\setup-env.ps1
```

The script creates a sibling virtual environment at `..\gsplat-env` by default. Override it with:

```powershell
.\environment\setup-env.ps1 -EnvironmentPath C:\path\to\gsplat-env
```

The package lock captures the original environment's Python packages. The setup script installs the CUDA-specific PyTorch wheels separately and installs this checkout last.

Some packages are platform-specific, and the Git dependencies require internet access. A different GPU, CUDA toolkit, Python version, or compiler may require compatible PyTorch/gsplat builds.

The raw virtual environment is intentionally excluded because Python virtual environments contain machine-specific paths and compiled binaries.

