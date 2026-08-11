from pytorch_msssim import ssim as _ssim


def fused_ssim(x, y, padding="valid"):
    return _ssim(
        x,
        y,
        data_range=1.0,
        size_average=True,
    )
