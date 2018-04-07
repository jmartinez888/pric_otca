$("#btn_nuevo_curso").click(function(){
  try{
    CargarPagina("gcurso/_view_mis_cursos", {}, false, $(this));
  }catch(e){
    if (e instanceof ReferenceError){
      alert("Error en direccionar");
    }
  }
});
