const modelViewer = document.querySelector('model-viewer');
const progressBarEl = modelViewer.querySelector('.progress-bar');

// Handles loading the events for <model-viewer>'s slotted progress bar
const onProgress = (event) => {
  const progressBar = event.target.querySelector('.progress-bar');
  const updatingBar = event.target.querySelector('.update-bar');
  updatingBar.style.width = `${event.detail.totalProgress * 100}%`;
  if (event.detail.totalProgress === 1) {
    progressBar.classList.add('hide');
    event.target.removeEventListener('progress', onProgress);
  } else {
    progressBar.classList.remove('hide');
  }
};
modelViewer.addEventListener('progress', onProgress);
modelViewer.addEventListener('load', () => {
  progressBarEl.classList.add('hide');
});

const modelSelectEl = document.getElementById('model');
const sizeSelectEl = document.getElementById('size');
const autorotateSelectEl = document.getElementById('autorotate');
const resetPositionEl = document.getElementById('reset-position');

const resetCameraImpl = () => {
  if (modelViewer.resetTurntableRotation) {
    modelViewer.resetTurntableRotation();
  }
  modelViewer.cameraOrbit = null;
  setTimeout(() => {
    modelViewer.cameraOrbit = modelViewer.getAttribute('camera-orbit');
  }, 100);
};

function resetCamera() {
  modelViewer.autoRotate = false;
  resetCameraImpl();
  setTimeout(() => {
    resetCameraImpl();
    modelViewer.autoRotate = autorotateSelectEl.value !== '-1';
  }, 100);
}

resetPositionEl.addEventListener('click', resetCamera);

const loadModel = () => {
  const modelId = modelSelectEl.value;
  const modelName = modelId.replace(/^\w+-/, '');
  const optionEl = modelSelectEl.querySelector(`option[value="${modelId}"]`);
  const consoleId = optionEl.closest('optgroup').getAttribute('value');

  progressBarEl.classList.remove('hide');

  modelViewer.src = `../${consoleId}/3dmodels/${modelName}/${modelName}.glb`;
  modelViewer.poster = `../${consoleId}/3dmodels/${modelName}/poster.webp`;
  modelViewer.removeAttribute('hidden');
};

function loadSize() {
  if (sizeSelectEl.value === '400px') {
    modelViewer.classList.add('gif');
  } else {
    modelViewer.classList.remove('gif');
  }
}

function loadAutorotate() {
  if (autorotateSelectEl.value === '-1') {
    modelViewer.autoRotate = false;
  } else {
    modelViewer.autoRotate = true;
    modelViewer.autoRotateDelay = parseInt(autorotateSelectEl.value) * 1000;
  }
}

window.addEventListener('popstate', (e) => {
  const modelId = e.state && e.state.modelId;
  if (modelId) {
    modelSelectEl.value = modelId;
  } else {
    const defaultOptionEl = modelSelectEl.querySelector('option[selected]');
    const firstOptionEl = modelSelectEl.querySelector('option:not(:disabled)');
    modelSelectEl.value = (defaultOptionEl || firstOptionEl).value;
  }

  const sizeId = e.state && e.state.sizeId;
  if (sizeId) {
    sizeSelectEl.value = sizeId;
  } else {
    const defaultOptionEl = sizeSelectEl.querySelector('option[selected]');
    const firstOptionEl = sizeSelectEl.querySelector('option:not(:disabled)');
    sizeSelectEl.value = (defaultOptionEl || firstOptionEl).value;
  }

  const autorotateId = e.state && e.state.autorotateId;
  if (autorotateId) {
    autorotateSelectEl.value = autorotateId;
  } else {
    const defaultOptionEl = autorotateSelectEl.querySelector('option[selected]');
    const firstOptionEl = autorotateSelectEl.querySelector('option:not(:disabled)');
    autorotateSelectEl.value = (defaultOptionEl || firstOptionEl).value;
  }

  loadModel();
});

const initialUrl = new URL(location);
const initialModel = initialUrl.searchParams.get('model');
const initialSize = initialUrl.searchParams.get('size');
const initialAutorotate = initialUrl.searchParams.get('autorotate');

if (initialModel) {
  modelSelectEl.value = initialModel;
}
if (initialSize) {
  sizeSelectEl.value = initialSize;
}
if (initialAutorotate) {
  autorotateSelectEl.value = initialAutorotate;
}

function pushUrlState() {
  const modelId = modelSelectEl.value;
  const sizeId = sizeSelectEl.value;
  const autorotateId = autorotateSelectEl.value;

  const curUrl = new URL(location);
  curUrl.searchParams.set('model',  modelId);
  curUrl.searchParams.set('size',  sizeId);
  curUrl.searchParams.set('autorotate',  autorotateId);

  const newUrl = curUrl.pathname + curUrl.search + curUrl.hash;

  history.pushState({modelId, sizeId, autorotateId}, '', newUrl);
}

loadSize();
loadAutorotate();
loadModel();

modelSelectEl.addEventListener('change', () => {
  pushUrlState();
  loadModel();
});

sizeSelectEl.addEventListener('change', () => {
  pushUrlState();
  loadSize();
});

autorotateSelectEl.addEventListener('change', () => {
  pushUrlState();
  loadAutorotate();
});
