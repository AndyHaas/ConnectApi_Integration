import { LightningElement, api, track } from 'lwc';

export default class Statistics_GetStatistics_CPE extends LightningElement {
    @api config;
    @api configType;
    @api configVersion;
    @api error;
    @api isLoading;

    @track localConfig = {
        startDate: '',
        endDate: '',
        metrics: [],
        dimensions: [],
        filters: []
    };

    @track showStartDate = true;
    @track showEndDate = true;
    @track showMetrics = true;
    @track showDimensions = true;
    @track showFilters = true;

    connectedCallback() {
        if (this.config) {
            this.localConfig = JSON.parse(JSON.stringify(this.config));
        }
    }

    handleStartDateChange(event) {
        this.localConfig.startDate = event.target.value;
        this.dispatchConfigChange();
    }

    handleEndDateChange(event) {
        this.localConfig.endDate = event.target.value;
        this.dispatchConfigChange();
    }

    handleMetricsChange(event) {
        this.localConfig.metrics = event.target.value;
        this.dispatchConfigChange();
    }

    handleDimensionsChange(event) {
        this.localConfig.dimensions = event.target.value;
        this.dispatchConfigChange();
    }

    handleFiltersChange(event) {
        this.localConfig.filters = event.target.value;
        this.dispatchConfigChange();
    }

    toggleSection(event) {
        const section = event.currentTarget.dataset.section;
        this[section] = !this[section];
    }

    validateConfig() {
        const errors = [];
        
        if (!this.localConfig.startDate) {
            errors.push('Start Date is required');
        }
        
        if (!this.localConfig.endDate) {
            errors.push('End Date is required');
        }
        
        if (!this.localConfig.metrics || this.localConfig.metrics.length === 0) {
            errors.push('At least one metric is required');
        }

        return errors;
    }

    dispatchConfigChange() {
        const errors = this.validateConfig();
        const configChangeEvent = new CustomEvent('configchange', {
            detail: {
                config: this.localConfig,
                errors: errors
            }
        });
        this.dispatchEvent(configChangeEvent);
    }

    handleSave() {
        const errors = this.validateConfig();
        if (errors.length === 0) {
            const saveEvent = new CustomEvent('save', {
                detail: {
                    config: this.localConfig
                }
            });
            this.dispatchEvent(saveEvent);
        }
    }

    handleCancel() {
        const cancelEvent = new CustomEvent('cancel');
        this.dispatchEvent(cancelEvent);
    }

    get metricOptions() {
        return [
            { label: 'Total Orders', value: 'total_orders' },
            { label: 'Total Revenue', value: 'total_revenue' },
            { label: 'Average Order Value', value: 'avg_order_value' },
            { label: 'Order Count', value: 'order_count' },
            { label: 'Customer Count', value: 'customer_count' }
        ];
    }

    get dimensionOptions() {
        return [
            { label: 'Date', value: 'date' },
            { label: 'Customer', value: 'customer' },
            { label: 'Product', value: 'product' },
            { label: 'Region', value: 'region' },
            { label: 'Status', value: 'status' }
        ];
    }

    get filterOptions() {
        return [
            { label: 'Status', value: 'status' },
            { label: 'Region', value: 'region' },
            { label: 'Customer Type', value: 'customer_type' },
            { label: 'Product Category', value: 'product_category' }
        ];
    }
} 