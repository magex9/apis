<html>
<head>
    <title>API Documentation</title>
</head>
<body>

    <h1>Designing Great API's</h1>

    <p>The way we are building software is changing.  Just as we want to provide end users a good user experience (UX), we must build an API that is optimized for developer experience (DX).</p>

    <p>There are a few core concepts that should be followed: </p>

    <ul>
        <li>The API should always be on (99.9% uptime or higher)</li>
        <li>The API should be lightning fast (keep response times low)</li>
        <li>The API should seamlessly update (no breaking changes)</li>
        <li>The API should expse building blocks, not static solutions</li>
    </ul>

    <p>This document is a group of concepts ive found while doing research on API's and are the key concepts most important to me.</p>

    <h2>Structure</h2>

    <p>The API is designed around the REST ideology, providing simple and predictable URL's to access and modify objects.  Requests support <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html">standard HTTP methods</a> like GET, PUT, POST and DELETE and <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html">standard HTTP status</a> codes.  Response bodies are always UTF-8 encoded JSON(-LD)objects unless explicitly documented otherwise.</p>

    <h2>Documentation</h2>

    <p>You can prove your API's worth in the docs themselves by allowing users to test a cURL response in the docs.</p>

    <p>Make sure developers can figure out the parameters of the API's SDK integration as quick as possible.  This is meant to save coding time and elimate any mental roadblocks hwile learning how your API functions within their framework fo choice.  With a simple NodeJS, Python or Java SDK, developers should be able to build a full-featured integration in a fraction of the time.</p>

    <ul>
        <li><a href="https://docs.nylas.com/reference#introduction">Nylas</a></li>
        <li><a href="https://swagger.developerhub.io/swagger-petstore/ref">Swagger</a></li>
        <li><a href="https://raml.org/">RAML</a></li>
        <li><a href="https://cxf.apache.org">Apache CXF</a></li>
    </ul>

    <h3>Treat your docs like the homepage of your website</h3>

    <p>Think of your API docs as the front page of your website. It's the central place users will bookmark and start using; it should be user-friendly, intuitive, and follow a logical flow.</p>

    <p>The API docs need to be inherently discoverable and easy to use, just like the API itself.  The docs must be easy to navigate with a clear table of contents and the main uses cases with examples right at the start.</p>

    <img src="homepage.png" />

    <p>Its important to ensure the API is usable, your interface is only as usable as your documentation, and your documentation is only helpful when its easily discoverable.  The documentation shouldd be organized in a consistent way that is searchable and provide contextual coverage across the entire API integration process.</p>

    <h2>Change is Inevitable</h2>

    <p>When building an API, change is inevitable.  SOAPAPI's lead the way to REST API's, and REST API's are the precursor to GRAPH API's.  JSON is the industry leading file format for today's APIS's but this is changing as technology develops.</p>

    <p>Its important to build in versioning from Day 1.  Taking fairly strict approach to change where it creates a new version of the API every time a change is necessary and changing nothing about the old version of the API will help keep companies using your API's.  Make sure that yhou communicate changes early and often to ensure your customes can prepare fo rthe changes and that no changes disrupt the end users services.  Using the basic major/minor sementaic versioning in your url can help.</p>

    <h2>Treat the API as a Product</h2>

    <p>A key factor when starting with any sort of development is the notion of the product. It defines the stand-alone entity that exposes useful functionality and benefits to the market. It is no easy task to design and implement an API that is easily consumable, scalable, properly documented, and secured without having a strong sense of responsibility and ownership in the process.</p>

    <h2>Filtering and Pagination</h2>

    <p>One common mistake when developing an API is not offering a way to filter or paginate results. When you expose an API that returns a list of items that can change over time, you need to establish a pagination strategy. The reason is simple. Clients, especially mobile ones, cannot view hundreds of list items at once. For example, you can show the first 10. If your API returns the whole database listing for each request, then a lot of resources are being wasted and the performance degrades substantially.</p>

    <p>Modern frameworks offer a way to paginate results, but you can also customize your own. A common approach is to use LIMIT and OFFSET statements on your queries. </p>

    <pre class="code">select * from people limit 5,10</pre>

    <p>That statement will retrieve the rows 6-16 from the database so you can provide a json response that give links to the first, next, previous and last page of that query based on the limit options.</p>

    <pre class="code">
{
    "first": "/api/v1/people?page=1",
    "prev": "/api/v1/people?page=1",
    "next": "/api/v1/people?page=3",
    "last": "/api/v1/people?page=9",
}
    </pre>

    <p>There are various ways to encode the propertname, the operator (such as eq, lte, gte) and the filter value for information you want to reduce.  It is important to list all possible options for filtering in your API documentation and enforce strong validation on the input like checking if its a valid number, date, etc.</p>

    <p>Sorting is also a very important feature for any API endpoint that returns lots of data.  Some endpoints without pagination, a simple search could return millions or billions of results resulting in API calls that take minutes or even hours.  To enable sorting add a sort parameter and add the ability to specify ascending or descending order.</p>

    <h2>Use REST and HATEAOS</h2>

    <p>REST is a proven and battle-tested architectural approach to providing API's, however its good to provide context around the set of resources without having prior knowledge of the internal URI scheme with th ehelp of HATEOAS.  It enhances the response model of each resource by providing a set of relevant links so that it is easier to interact with the API.  Without looking up a specification or other metadata service.  One good format of HATEAOS is the <a href="https://en.wikipedia.org/wiki/Hypertext_Application_Language">HAL</a> specification.</p>

    <pre class="code">
{
    "_links": {
        "self": {
            "href": "/api/v1/people/1"
        },
        "/rels/people": [{
            "href": "/api/v1/people/84",
            "name": "Scott"
        },{
            "href": "/api/v1/people/94",
            "name": "Mike"
        }]
    }
}
    </pre>

    <h2>Secure the Endpoints</h2>

    <p>Security should not be neglected.  Any breach can have a catastrophic consequence and lead to serious legal issues.  Security controls need to be established early in the development process and your API <b>must</b> be accessed by na external vendor to ensure it will not be maliciously exploited.  The CIA triad of security applies with the following:</p>

    <ul>
        <li><b>C</b>onfidentiality is achieved by adding proper authentication controls that provide a means for your system to know who is accessing information or sites. <a href="https://en.wikipedia.org/wiki/OAuth">OAuth2</a> and <a href="https://en.wikipedia.org/wiki/JSON_Web_Token">JWT</a> offer a practical and secure means of authenticating controls. <b>HTTPS</b> <b>must</b> be used at all public endpoints to ensure secure communications.</li>
        <li><b>I</b>ntegrity is achieved by using access controls and authorization strategies to prevent the tampering of data from unauthorized users. Role-Based Authorization Control (RBAC) provides a good option.</li>
        <li><b>A</b>vailability is achieved by establishing <b>rate limits, partial responses and caching</b>, in order to prevent extensive usage of API resources or even servers taken down by infinite loops.</li>
    </ul>

    <h3>Top API Security Threats</h3>

    <ol>
        <li>Injection Attacks - dangerous code is embedded into an unsecured software to stage an attack, most notably SQL injection and cross-site scripting.</li>
        <li>DoS Attacks - the attacker pushes an enormous amount of messages requsting the server or network into a non-functional state.</li>
        <li>Broken Authentication - missing or inadequate authentication can result in an attack whereby JSON web tokens, API keys, passwords etc can be bypassed or compromised.</li>
        <li>Sensitive Data Exposure - whenever an application is unable to properly secure sensitive data, private information can be retrieved by an attacker.</li>
        <li>Broken Access Control - when authentication is involved, web applications allow access to function and content to certian people not everyone, missing access controls can give information out to the attacker.</li>
        <li>Parameter Tampering - happens when a harmful website, program, blog or email makes a user's internet browser carry out an unnecessary action on an authorized site.</li>
        <li>Man In The Middle Attack (MITM) - an attacker is secretly altering, intercepting or relaying communications between two interacting systems and intercepts the private data passed between them.</li>
        <li>Loack of TLS - any website running on http and not https is practically equivalent to handing out open invations to hackers.</li>
    </ol>

    <h2>Caching</h2>

    <p>It is easy to ignore the caching by including the header "Cache-control: no-cache" in responses of your API calls.  HTTP defines a powerful caching mechanism that includes ETag header, If-Modified-Since header, and 304 Not Modified response code.  They allow your clients and servers to negotiate always a fresh copy of the resource and through caching or proxy servers increas your applications scalability and performance.</p>

    <p>The following ar ethe high level steps where the response header "ETag" along with conditional request header "If-None-Match" is used to cache the resource copy in the client brower:</p>

    <ol>
        <li>The server receives a normal HTTPD request for a particular resource, id=123 to get the details.</li>
        <li>The server prepares the response, but in order to help the brower with caching, it includes the header "ETag" with the value of the response: "ETag: 'Version1'".</li>
        <li>The server sends the response with the above header, the content of the project 123 in the boy with the status code of 200.  The browser renders the resource and at the same time caches the resource copy along with the header information.</li>
        <li>Later the same browser makes another request for the same resource project 123 but with following conditional request headre "If-None-Match: 'Version1'".</li>
        <li>On receiving the request for project 123 along with "If-None-Match" header, the server logic checks if project 123 needs a new copy by comparing the current ETag identifier generated on the content of project 123 and the one that is recived in the request header.</li>
        <li>If the request's If-None-Match is the same as the currently generated/assigned value of ETag on the server, then status code 304 (Not Modified) with the empty body is sent back and the browser that uses a cached copy of project 123.</li>
        <li>If the requests If-None-Match value doesnt match the currently generated/ assigned value of ETag (ex: version2) for project 123, then the server sends back the new content in the body along with the status code 200.  The ETag header with the new value is also included in the response.  The browser uses the new project 123 an dupdates its cache with th enew data.</li>
    </ol>

    <h2>Use Monitoring and Reporting</h2>

    <p>While developing and testing your API plays a big part in the process, the real work does not end here. You need to continue providing support, even before the code is deployed to production. If something goes wrong, the right people need to be notified with actionable information, in order to respond by any means necessary. This constitutes a proactive approach when developing your API. If you keep things at bay, when endpoint issues emerge, you can prevent any catastrophic failures.</p>

    <h2>How to Prevent DDoS Attacks</h2>

    <p>There are different ways we can prevent DDoS attacks; we can do IP blacklisting to avoid traffic from sources of attack, rate limit your application to prevent it from being overwhelmed, or use both of them to provide multiple layers of security.</p>

    <p><a href="https://dzone.com/articles/implementing-ddos-with-mulesoft-demonstration-with">Implementing a DoS attack with JMeter and Mulesoft.</a></p>

    <h2>Level of Granularity</h2>

    <p>Granularity is an essential principle of REST API design. As we understand, business functions divided into many small actions are fine-grained, and business functions divided into large operations are coarse-grained. </p>

    <p>In some cases, calls across the network may be expensive, so to minimize them, coarse-grained APIs may be the best fit, as each request from the client forces lot of work at the server side, and in fine-grained, many calls are required to do the same amount of work at the client side. </p>

    <p>Example: Consider a service returns customer orders in a single call. In case of fine-grained, it returns only the customer IDs, and for each customer id, the client needs to make an additional request to get details, so n+1 calls need to be made by the clients. It may be expensive round trips regarding its performance and response times over the network.</p>

    <p>In a few other cases, APIs should be designed at the lowest practical level of granularity, because combining them is possible and allowed in ways that they suit the customer needs.</p>

    <p>Example: An electronic form submission may need to collect addresses as well as, say, tax information. In this case, there are two functions: one is a collection of applicant's whereabouts, and another is a collection of tax details. Each task needs to be addressed with a distinct API and requires a separate service because an address change is logically a different event and not related to tax time reporting, i.e., why one needs to submit the tax information (again) for an address change. </p>

    <ul>
        <li>In general, consider that the services may be coarse-grained, and API's are fine-grained.</li>
        <li>Maintain a balance between the amount of response data and the number of resources required to provide that data. It will help decide the granularity.</li>
        <li>Read requests are normally coarse-grained. Returning all information as required to render the page; it won’t hurt as much as two separate API calls in some cases.</li>
        <li>On the other hand, write requests must be fine-grained. Find out everyday operations clients needs, and provide a specific API for that use case.</li>
    </ul>

    <h2>More...</h2>

    <p>Other useful links to gather information from:</p>

    <ul>
        <li><a href="https://dzone.com/storage/assets/9815686-dzone-refcard129-restfularchitecture.pdf">https://dzone.com/storage/assets/9815686-dzone-refcard129-restfularchitecture.pdf</a></li>
        <li><a href="https://www.ict.govt.nz/guidance-and-resources/standards-compliance/api-standard-and-guidelines/api-standard-and-guidelines-part-b-technical/">https://www.ict.govt.nz/guidance-and-resources/standards-compliance/api-standard-and-guidelines/api-standard-and-guidelines-part-b-technical/</a></li>
        <li><a href="https://www.gov.uk/guidance/gds-api-technical-and-data-standards#when-to-authenticate-your-api">https://www.gov.uk/guidance/gds-api-technical-and-data-standards#when-to-authenticate-your-api</a></li>
        <li><a href="https://backendless.com/docs/images/shared/backendless-architecture.png">https://backendless.com/docs/images/shared/backendless-architecture.png</a></li>
        <li><a href="https://www.getpostman.com/">https://www.getpostman.com/</a></li>
    </ul>

</body>
</html>