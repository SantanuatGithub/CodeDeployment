public virtual class Marker {
    public Marker(){
        
    }
    
    public void call(){
        write();
    }
    
    private void write() {
        System.debug('Writing some text.');
    }

    public virtual Double discount() {
        return .05;
    }
}