<div class="modal fade" id="mod_difusion" tabindex="-1" role="dialog" aria-labelledby="mod_difusion">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Estado</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" data-toggle="validator" @submit.prevent="onSubmit_buscarDifusion"  role="form"  novalidate="true" id="actualizar_attr">
          <div class="form-group">
            <div class="col-sm-8">
              <input type="text" ref="filter_difusion_name" name="filter_difusion_name" id="filter_difusion_name" class="form-control" value="" required="required"  placeholder="Buscar difusión">
            </div>
            <div class="col-sm-4">
              <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;Buscar</button>
            </div>
          </div>
          <table class="table table-hover table-minimal">
            <thead>
              <tr>
                <th width="40">#</th>
                <th>Disufio</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in difusiones">
                <td><input type="radio" name="difusion_selected" :value="item.ODif_IdDifusion" v-model="difusion_id"></td>
                <td>{literal}{{item.ODif_Titulo}}{/literal}</td>
              </tr>
            </tbody>
          </table>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
        <button type="button"  class="btn btn-primary" @click="onClick_saveDifusion">Guardar</button>
      </div>
    </div>
  </div>
</div>