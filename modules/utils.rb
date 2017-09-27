module Utils 
  
  def keypress
    system("stty raw -echo")
    char = STDIN.getc
    system("stty -raw echo")
    char
  end  
  
  def clrscr
    system('clear')
  end
    
end