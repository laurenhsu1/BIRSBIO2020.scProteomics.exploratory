# 1a, 1b
find_ct_expr <- function(x, labs){
  # when elements are in columns and sums should be rowwise
  ct_expr <- data.frame(matrix(nrow = length(unique(labs)), ncol = nrow(x)))
  rownames(ct_expr) <- unique(labs)
  colnames(ct_expr) <- rownames(x)
  for(ct in unique(labs)){
    if(sum(labs == ct) == 1){
      ct_expr[ct,] <- t(x[,which(labs == ct)]/sum(labs == ct))
    }
    else{
      ct_expr[ct,] <- t(rowSums(x[,which(labs == ct)])/sum(labs == ct))
    }
  }
  return(ct_expr)
}

# 1b1
norm01 <- function(x){
  x[which(is.na(x))] <- 0
  res <- (x - min(x)) / (max(x) - min(x))
  res[which(is.na(res))] <- 0
  return(res)
}
