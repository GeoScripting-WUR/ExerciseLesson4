# Loic Dutrieux
# 

library(raster)

source('R/dir2ndvi.R')

# Calculate NDVI and mask clouds
ndvi8 <- dir2ndvi('data/LC81970242014109/', 4, 5)
ndvi5 <- dir2ndvi('data/LT51980241990098/', 3, 4)

# Find intersecting extent and crop layers with it
e <- intersect(extent(ndvi8), extent(ndvi5))
ndvi8Sub <- crop(ndvi8, e)
ndvi5Sub <- crop(ndvi5, e)

# compute difference
diff <- ndvi8Sub - ndvi5Sub

# VIsualize Extents
plot(ndvi5, zlim = c(-0.1, 1))
plot(ndvi8, zlim = c(-0.1, 1), add = TRUE)
plot(extent(ndvi8), add = TRUE)
plot(extent(ndvi5), add = TRUE)

# Visualize difference
plot(diff, zlim = c(-1,1))

# MOre visualization
opar <- par(mfrow = c(2,2))
plot(ndvi5Sub, zlim = c(-0.1, 1), main = '1990')
plot(ndvi8Sub, zlim = c(-0.1, 1), main = '2014')
plot(diff, zlim = c(-1,1), main = 'NDVI change 1990-2014')
par(opar)