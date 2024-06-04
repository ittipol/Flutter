class MathHelper {
  static int fibonacci(int n) {
    if (n == 1){
      return 0;
    }
    else if (n == 2){
      return 1;
    } 
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}