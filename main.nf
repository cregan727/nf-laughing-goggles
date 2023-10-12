#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { reffree_workflow } from './subworkflows/wf-reference_free.nf'
include { ref_bams } from './subworkflows/wf-reference_bams.nf'

workflowChoice = params.workflow ?: 'ref_free'


workflow {


    if (workflowChoice == 'ref_bams') {
        params.samplesheet_bams = params.samplesheet_bams ?: 'sample_sheet_bams.csv'
        ref_bams()
    }
    
    if (workflowChoice == 'ref_free') {
        params.numsamples = params.numsamples ?: 2
        reffree_workflow()
    }

    // Define other common parameters
    params.samplesheet = params.samplesheet ?: 'samplesheet.csv'
    params.regionvcf = params.regionvcf ?: 'regions.vcf.gz'
    params.publishDir = params.publishDir ?: 'Results'


}
