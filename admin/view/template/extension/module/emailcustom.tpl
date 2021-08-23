<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-emailcustom" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-emailcustom" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="emailcustom_status" id="input-status" class="form-control">
                <?php if ($emailcustom_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <ul class="nav nav-tabs" id="language">
            <?php foreach ($languages as $language) { ?>
            <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
            <?php } ?>
          </ul>
          <div class="tab-content">
          <?php foreach ($languages as $language) { ?>
            <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
            <?php foreach ($order_statuses as $os) { ?>
              <?php $varentry = 'entry_' . $os['order_status_id'];?>
              <?php //print_r($$varentry) . "\n";?>
              <?php $varstatus = 'emailcustom_' . $language['language_id'] . '_' . $os['order_status_id'];?>
                <!--<div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-<?php echo $language['language_id'];?>-<?php echo $os['order_status_id'];?>"><span data-toggle="tooltip" data-html="true" data-trigger="click" title="titlexx"><?php echo $$varentry; ?></span></label>
                  <div class="col-sm-10">
                    <textarea name="<?php echo $varstatus;?>" rows="10" id="input-<?php echo $language['language_id'];?>-<?php echo $os['order_status_id'];?>" class="form-control"><?php echo $$varstatus; ?></textarea>
                  </div>
                </div>-->
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-<?php echo $language['language_id'];?>-<?php echo $os['order_status_id'];?>"><?php echo $$varentry; ?></label>
                    <div class="col-sm-10">
                      <textarea name="<?php echo $varstatus;?>" placeholder="<?php echo $$varentry; ?>" id="input-<?php echo $language['language_id'];?>-<?php echo $os['order_status_id'];?>" class="form-control summernote"><?php echo $$varstatus; ?></textarea>
                    </div>
                  </div>

            <?php } ?>
            </div>
          <?php } ?>
          </div>  
          <!---->
                    
        </form>
      </div>
    </div>
  </div>
</div>
  <script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
  <link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
  <script type="text/javascript" src="view/javascript/summernote/opencart.js"></script> 

<?php echo $footer; ?>