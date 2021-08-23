<?php
class ControllerExtensionModuleEmailcustom extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/emailcustom');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('localisation/order_status');
		$this->load->model('localisation/language');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('emailcustom', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_code'] = $this->language->get('entry_code');
		$data['entry_status'] = $this->language->get('entry_status');

		$data['help_code'] = $this->language->get('help_code');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$order_statuses = $this->model_localisation_order_status->getOrderStatuses();
		$languages = $this->model_localisation_language->getLanguages();
		$data['order_statuses'] = $order_statuses; 
		$data['languages'] = $languages;
		foreach ($languages as $language) {
			//print_r($data['entry_' . $os['order_status_id']] . '-');
			foreach ($order_statuses as $os) {
				$data['entry_' . $os['order_status_id']] = $os['name'];
				if (isset($this->request->post['emailcustom_' . $language['language_id'] . '_' . $os['order_status_id']])) {
					$data['emailcustom_' . $language['language_id'] . '_' . $os['order_status_id']] = $this->request->post['emailcustom_' . $language['language_id'] . '_' . $os['order_status_id']];
				} else {
					$data['emailcustom_' . $language['language_id'] . '_' . $os['order_status_id']] = $this->config->get('emailcustom_' . $language['language_id'] . '_' . $os['order_status_id']);
				}
			}
		}
		//print('<pre>' . print_r($order_statuses,true) . '</pre>');
		//print('<pre>' .  print_r($data,true) . '</pre>');
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['code'])) {
			$data['error_code'] = $this->error['code'];
		} else {
			$data['error_code'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/emailcustom', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/emailcustom', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);


		if (isset($this->request->post['emailcustom_status'])) {
			$data['emailcustom_status'] = $this->request->post['emailcustom_status'];
		} else {
			$data['emailcustom_status'] = $this->config->get('emailcustom_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/emailcustom', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/emailcustom')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		/*if (!$this->request->post['emailcustom_code']) {
			$this->error['code'] = $this->language->get('error_code');
		}*/

		return !$this->error;
	}
}