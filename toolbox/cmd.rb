class String
    # add a - operator to strings that makes it behave like a system() call 
    # but it shows stderr 
    def -@
        return Process.wait(Process.spawn(self))
    end
end