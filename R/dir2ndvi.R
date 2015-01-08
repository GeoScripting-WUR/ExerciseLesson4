dir2ndvi <- function(x, red, nir) {
    RED <- raster(list.files(x, pattern = sprintf('^.*band%d.*\\.tif$', red), full.names = TRUE))
    NIR <- raster(list.files(x, pattern = sprintf('^.*band%d.*\\.tif$', nir), full.names = TRUE))
    mask <- raster(list.files(x, pattern = '^.*cfmask.*\\.tif$', full.names = TRUE))
    
    ndviFun <- function(x, y) {
        out <- (y - x) / (y + x)
        return(out)
    }
    
    maskFun <- function(x, y) {
        x[y != 0] <- NA
        return(x)
    }
    
    ndvi0 <- overlay(RED, NIR, fun=ndviFun)
    overlay(ndvi0, mask, fun=maskFun)
}