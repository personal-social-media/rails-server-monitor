import '../stylesheets/main.scss';
require('typeface-roboto');
import '@fortawesome/fontawesome-free/css/all.css';

import 'chartkick/chart.js';
import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';

Rails.start();
Turbolinks.start();

import 'controllers';

// const componentRequireContext = require.context('components', true);
// const ReactRailsUJS = require('react_ujs');
// ReactRailsUJS.useContext(componentRequireContext); // eslint-disable-line react-hooks/rules-of-hooks
// ReactRailsUJS.handleEvent('turbolinks:load', ReactRailsUJS.handleMount);
